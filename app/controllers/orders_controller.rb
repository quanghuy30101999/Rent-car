class OrdersController < ApplicationController
  def index
    @orders = Order.all
    @orders = Order.search_order(params) if admin? && params[:search_order].present?
    @group = Order.reorder(:orders_status).group(:orders_status).count if admin?
    unless admin?
      @orders = @orders.where(user_id: current_user.id)
      @orders = @orders.search_order(params) if params[:search_order].present?
      @group = @orders.reorder(:orders_status).group(:orders_status).count
    end
  end

  def new
    @car = Car.find(params[:car_id])
    @order ||= Order.new
  end

  def update
  end

  def cancelled
    @order = Order.find_by(id: params[:order_id])
    @car = @order.car
    @order.cancelled!
    @car.update(status: "available", begin: nil, end: nil)
    @orders = Order.all
    redirect_to current_user
  end

  def create
    @car = Car.find(params[:car_id])
    @order = @car.orders.build(order_params)
    unless check_day(params)
      if !check_order(params)
        @order.user_id = current_user.id
        if @order.save
          @car.update(status: "ordered", begin: @order.rent_time, end: @order.return_time)
          flash[:success] = "Order created!"
          redirect_to current_user
        else
          render "orders/new"
        end
      else
        flash[:danger] = "time already exists"
        render "orders/new"
      end
    else
      flash[:danger] = "You have to return the car among 20 day from day's rent"
      render "orders/new"
    end
  end

  def deny
    @order = Order.find_by(id: params[:order_id])
    @car = @order.car
    @order.deny!
    @car.update(status: "available", begin: nil, end: nil)
    @orders = Order.all
    render "orders/index"
  end

  def approved
    @order = Order.find_by(id: params[:order_id])
    @car = @order.car
    @order.approved!
    @car.rented!
    @orders = Order.all
    render "orders/index"
  end

  def destroy
    @car = Car.find(params[:car_id])
    @order = @car.orders.destroy(params[:id])
    @car.available!
    flash[:success] = "Order deleted"
    redirect_to current_user
  end

  private

  def order_params
    datetime_string = params[:order][:rent_time]
    params[:order][:rent_time] = DateTime.strptime(datetime_string, "%m/%d/%Y %l:%M %p")
    datetime_string_2 = params[:order][:return_time]
    params[:order][:return_time] = DateTime.strptime(datetime_string_2, "%m/%d/%Y %l:%M %p")
    params.require(:order).permit(:phone, :rent_time, :return_time)
  end
end

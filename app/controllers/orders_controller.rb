class OrdersController < ApplicationController
  before_action :logged_in_user

  def index
    @extension_orders = []
    if admin?
      @requesting = Order.where(status: "requesting")
      @approved = Order.where(status: "approved")
      @approved.each do |order|
        @extension_orders += order.extension_orders
      end
      @order = Order.where("status = ? OR status = ? OR status = ?", "finished", "denied", "cancelled")
      @orders = Order.search_order(params) if params[:search_order].present?
      @group = Order.reorder(:status).group(:status).count
      @group_extension = ExtensionOrder.reorder(:status).group(:status).count
    else
      @orders = Order.where(user_id: current_user.id)
      @approved_orders = @orders.where(status: "approved")
      @approved_orders.each do |order|
        @extension_orders += order.extension_orders
      end
      @group = @orders.reorder(:status).group(:status).count
      @orders = @orders.search_order(params) if params[:search_order].present?
    end
  end

  def new
    @car = Car.find(params[:car_id])
    @order ||= Order.new(phone: current_user.phone)
    @user = User.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = "Update success"
      redirect_to orders_path
    else
      render "orders/edit"
    end
  end

  def cancelled
    @order = Order.find(params[:order_id])
    @car = @order.car
    @order.cancelled!
    @car.update(status: "available", begin: nil, end: nil)
    @orders = Order.all
    redirect_to orders_path
  end

  def create
    @car = Car.find(params[:car_id])
    @order = @car.orders.build(order_params)
    unless check_day(params)
      if !check_order(params)
        @order.user_id = current_user.id
        if @order.save!
          @car.update(status: "ordered", begin: @order.rent_time, end: @order.return_time)
          flash[:success] = "Order created!"
          redirect_to orders_path
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
    @order = Order.find(params[:order_id])
    @car = @order.car
    @order.denied!
    @car.update(status: "available", begin: nil, end: nil)
    redirect_to orders_path
  end

  def approved
    @order = Order.find(params[:order_id])
    @car = @order.car
    @order.approved!
    @car.rented!
    redirect_to orders_path
  end

  def destroy
    @car = Car.find(params[:car_id])
    @order = @car.orders.destroy(params[:id])
    @car.available!
    flash[:success] = "Order deleted"
    redirect_to orders_path
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

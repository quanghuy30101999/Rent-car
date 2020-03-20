class OrdersController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @order ||= Order.new
  end

  def create
    @car = Car.find(params[:car_id])
    @order = @car.orders.build(order_params)
    unless OrdersHelper.check_day(params)
      @order.user_id = current_user.id
      if @order.save
        @car.update(status: "ordered", begin: @order.rent_time, end: @order.return_time)
        flash[:success] = "Order created!"
        redirect_to current_user
      else
        render "orders/new"
      end
    else
      flash[:danger] = "You have to return the car among 20 day from day's rent"
      render "orders/new"
    end
  end

  def destroy
    @car = Car.find(params[:car_id])
    @order = @car.orders.destroy(params[:id])
    @car.update status: "available"
    flash[:success] = "Order deleted"
    redirect_to current_user
  end

  private

  def order_params
    datetime_string = params[:order][:rent_time]
    params[:order][:rent_time] = DateTime.strptime(datetime_string, "%m/%d/%Y %l:%M %p")
    datetime_string_2 = params[:order][:return_time]
    params[:order][:return_time] = DateTime.strptime(datetime_string_2, "%m/%d/%Y %l:%M %p")
    params.require(:order).permit(:name, :email, :rent_time, :return_time)
  end
end

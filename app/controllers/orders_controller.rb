class OrdersController < ApplicationController
  def new
    @car = Car.find(params[:car_id])
    @order = @car.orders.build
  end

  def create
    @car = Car.find(params[:car_id])
    @order = @car.orders.build(order_params)
    @car.update(status: "ordered")
    @order.user_id = current_user.id
    if @order.save
      @car.save
      flash[:success] = "Order created!"
      redirect_to @car
    else
      render "orders/new"
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :rent_time, :return_time)
  end
end

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
      redirect_to current_user
    else
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
    params.require(:order).permit(:name, :email, :rent_time, :return_time)
  end
end

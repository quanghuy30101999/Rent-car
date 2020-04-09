class ExtensionOrdersController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_extension = ExtensionOrder.new
  end

  def cancelled
    @extension_order = ExtensionOrder.find(params[:extension_order_id])
    @extension_order.cancelled!
    redirect_to orders_path
  end

  def deny
    @extension_order = ExtensionOrder.find(params[:extension_order_id])
    @extension_order.deny!
    redirect_to orders_path
  end

  def approved
    @extension_order = ExtensionOrder.find(params[:extension_order_id])
    @order = @extension_order.order
    if @extension_orders = @order.check_extension_orders_approved
      @extension_orders.finished!
    end
    @extension_order.approved!
    @order.update(request_date: @extension_order.return_time)
    redirect_to orders_path
  end

  def create
    @order = Order.find(params[:order_id])
    @car = @order.car
    @order_extension = @order.extension_orders.build(order_extension_params)
    if @order_extension.save
      flash[:success] = "Order created!"
      redirect_to orders_path
    else
      render "extension_orders/new"
    end
  end

  private

  def order_extension_params
    params[:extension_order][:rent_time] = Time.now
    params.require(:extension_order).permit(:rent_time, :return_time)
  end
end

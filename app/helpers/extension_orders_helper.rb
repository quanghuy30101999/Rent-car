module ExtensionOrdersHelper
  def get_car_to_order_extension(order_id)
    order_parent = Order.find(order_id)
  end
end

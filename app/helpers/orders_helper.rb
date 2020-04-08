module OrdersHelper
  def check_day(params)
    rent_time = params[:order][:rent_time]
    return_time = params[:order][:return_time]
    (return_time - rent_time).to_i > 20 if rent_time.present? && return_time.present?
  end

  def check_order(params)
    rent_time = params[:order][:rent_time]
    return_time = params[:order][:return_time]
    orders = Order.where(status: "approved")
    orders = orders.where("return_time > ?", Time.now)
    car_id = params[:car_id].to_i
    orders = orders.where(car_id: car_id)
    orders.any? do |order|
      order.rent_time <= rent_time.to_date && rent_time.to_date <= order.return_time || order.rent_time <= return_time.to_date && return_time.to_date <= order.return_time
    end
  end

  def order_show(status)
    status != "deny" && status != "approved" && status != "cancelled"
  end

  def check_oders_status(status)
    status == "approved"
  end

  def get_car(params)
    Car.find_by(id: params[:car_id])
  end

  def check_order_
    current_user.orders.any? do |order|
      order.approved? && (Time.now.to_date - order.created_at.to_date).to_i < 1
    end
  end

  def hide_extension(order_id)
    order = Order.find(order_id)
    order.extension_orders.any? do |extension_orders|
      extension_orders.requesting?
    end
  end

  def check_extension_orders(order_id)
    order = Order.find(order_id)
    order.extension_orders.any? do |extension_orders|
      extension_orders.approved?
    end
  end

  def get_order_parent(order_id)
    order = Order.find(order_id)
    extension_order = []
    order.extension_orders.each do |extension_orders|
      extension_order.push(extension_orders) if extension_orders.approved?
    end
    max_return_time = Time.now
    orders = []
    extension_order.each do |order|
      orders = order if order.return_time > max_return_time
      max_return_time = order.return_time
    end
    orders
  end
end

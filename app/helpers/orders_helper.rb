module OrdersHelper
  def self.check_day(params)
    rent_time = params.dig(:order, :rent_time)
    return_time = params.dig(:order, :return_time)
    (return_time.to_date - rent_time.to_date).to_i > 20
  end

  def self.check_order(params)
    rent_time = params.dig(:order, :rent_time)
    return_time = params.dig(:order, :return_time)
    orders = Order.where(orders_status: "approved")
    orders = orders.where("return_time > ?", Time.now)
    byebug
    orders.any? do |order|
      order.rent_time <= return_time.to_date || order.return_time >= rent_time.to_date
    end
  end

  def order_show(orders_status)
    orders_status != "deny" && orders_status != "approved"
  end
end

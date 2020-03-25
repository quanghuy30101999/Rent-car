module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    base_title = "Rent Car"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_currency(price, price_unit)
    price_symbol = (price_unit == "USD") ? "$" : "đ"
    (price_unit == "USD") ? "#{price_symbol}#{price}" : "#{price}#{price_symbol}"
  end

  def user_oreded?(car_id)
    current_user.orders.any? do |order|
      order.car_id == car_id && order.requesting?
    end
  end
end

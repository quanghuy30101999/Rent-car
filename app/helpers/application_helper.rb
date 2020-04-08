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
    (price_unit == "USD") ? "$#{price}" : "#{price}đ"
  end

  def user_oreded?(car_id)
    current_user.orders.any? do |order|
      order.car_id == car_id && order.requesting?
    end
  end
end

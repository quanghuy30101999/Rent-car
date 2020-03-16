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
    price_symbol = "đ"
    if price_unit == "USD"
      price_symbol = "$"
      currency = price_symbol + price.to_s
    else
      currency = price.to_s + price_symbol
    end
  end
end

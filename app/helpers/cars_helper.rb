module CarsHelper
  def price_unit(car)
    price_unit = "đ"
    if car.price_unit == "USD"
      price_unit = "$"
    else
      price_unit
    end
  end
end

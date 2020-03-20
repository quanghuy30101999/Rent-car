module OrdersHelper
  def self.check_day(params)
    rent_time = params.dig(:order, :rent_time)
    return_time = params.dig(:order, :return_time)
    (return_time.to_date - rent_time.to_date).to_i > 20
  end
end

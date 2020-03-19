class Car < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :year, presence: true
  validates :color, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }
  enum status: { available: "available", ordered: "ordered", rented: "rented" }
  validates :status, presence: true, inclusion: { in: %w(available ordered rented) }
  enum price_unit: { VND: "VND", USD: "USD" }
  validates :price_unit, presence: true, inclusion: { in: %w(VND USD) }

  def self.search(params)
    cars = Car.all
    cars = cars.where("lower(name) LIKE :search OR lower(color) LIKE :search OR lower(year) LIKE :search", search: "%#{params[:search].downcase}%") if params[:search].present?
    if params[:date_rent].present? && params[:date_return].present?
      car_available = cars.where("cars.begin is null")
      cars_rented = cars.where("cars.begin is not null and cars.end <= ? OR cars.begin >= ?", params[:date_rent].to_date, params[:date_return].to_date)
      car_available += car_rented
      cars = car_available
    end
    cars
  end
end

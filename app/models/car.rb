class Car < ApplicationRecord
  has_many :orders, dependent: :destroy
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
    car_available = cars.where("cars.begin is null") if params[:DateRent].present? && params[:DateReturn].present?
    car_rented = cars.where("cars.begin is not null") if params[:DateRent].present? && params[:DateReturn].present?
    car_rented = car_rented.where("cars.end <= ? OR cars.begin >= ?", params[:DateRent].to_date, params[:DateReturn].to_date) if params[:DateRent].present? && params[:DateReturn].present?
    car_available += car_rented if params[:DateRent].present? && params[:DateReturn].present?
    cars = car_available if params[:DateRent].present? && params[:DateReturn].present?
    cars
  end
end

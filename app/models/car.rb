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
    if params[:available_from].present? && params[:available_to].present?
      cars = cars.where("cars.begin is null or cars.end <= ? OR cars.begin >= ?", params[:available_from].to_date, params[:available_to].to_date)
    end
    cars
  end
end

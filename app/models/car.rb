class Car < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 50}
  validates :year, presence: true
  validates :color, presence: true
  validates :price, presence: true,
            numericality: { only_integer: true }
  enum status: { available: 'available', ordered: 'ordered', rented: 'rented' }
  validates :status,        presence: true, inclusion: {in: %w(available ordered rented)}
end
class Car < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 50}
  validates :namsx, presence: true
  validates :color, presence: true
  validates :price, presence: true,
            numericality: { only_integer: true }
end
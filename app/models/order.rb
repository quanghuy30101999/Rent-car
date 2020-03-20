class Order < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :rent_time, presence: true
  validates :return_time, presence: true
  enum orders_status: { requesting: "requesting", approved: "approved", finished: "finished" }
  validates :orders_status, presence: true, inclusion: { in: %w(requesting approved finished) }
end

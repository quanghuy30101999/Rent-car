class Order < ApplicationRecord
  belongs_to :user
  belongs_to :car
  enum orders_status: { requesting: "requesting", approved: "approved", finished: "finished" }
  validates :orders_status, presence: true, inclusion: { in: %w(requesting approved finished) }
end

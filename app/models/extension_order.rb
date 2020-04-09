class ExtensionOrder < ApplicationRecord
  belongs_to :order
  enum status: { requesting: "requesting", approved: "approved", finished: "finished", denied: "denied", cancelled: "cancelled" }
  validates :status, presence: true, inclusion: { in: %w(requesting approved finished denied cancelled) }

  def order_show
    order = ExtensionOrder.find(id)
    order.status != "denied" && order.status != "approved" && order.status != "cancelled" && order.status != "finished"
  end
end

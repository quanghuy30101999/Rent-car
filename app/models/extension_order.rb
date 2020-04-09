class ExtensionOrder < ApplicationRecord
  belongs_to :order
  enum status: { requesting: "requesting", approved: "approved", finished: "finished", deny: "deny", cancelled: "cancelled" }
  validates :status, presence: true, inclusion: { in: %w(requesting approved finished deny cancelled) }

  def order_show
    order = ExtensionOrder.find(id)
    order.status != "deny" && order.status != "approved" && order.status != "cancelled" && order.status != "finished"
  end
end

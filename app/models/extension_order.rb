class ExtensionOrder < ApplicationRecord
  belongs_to :order
  enum status: { requesting: "requesting", approved: "approved", finished: "finished", deny: "deny", cancelled: "cancelled" }
  validates :status, presence: true, inclusion: { in: %w(requesting approved finished deny cancelled) }
end

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :extension_orders, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :phone, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }
  validate :checkin_time_cannot_be_in_the_past
  validate :return_time_cannot_be_in_the_rent_time
  validates :rent_time, presence: true
  validates :return_time, presence: true
  enum status: { requesting: "requesting", approved: "approved", finished: "finished", denied: "denied", cancelled: "cancelled" }
  validates :status, presence: true, inclusion: { in: %w(requesting approved finished denied cancelled) }
  def self.search_order(params)
    @orders = Order.where(status: params[:search_order]) if params[:search_order].present?
  end

  def check_extension_orders
    order = Order.find(id)
    order.extension_orders.any? do |extension_orders|
      extension_orders.approved?
    end
  end

  def check_extension_orders_approved
    order = Order.find(id)
    order.extension_orders.each do |extension_orders|
      @extension_order = extension_orders if extension_orders.approved?
    end
    @extension_order
  end

  def order_show
    order = Order.find(id)
    order.status != "denied" && order.status != "approved" && order.status != "cancelled" && order.status != "finished"
  end

  def hide_extension
    order = Order.find(id)
    order.extension_orders.any? do |extension_orders|
      extension_orders.requesting?
    end
  end

  def get_order_parent
    order = Order.find(id)
    extension_order = order.extension_orders.select { |order_extension| order_extension.approved? }
  end

  private

  def checkin_time_cannot_be_in_the_past
    if (rent_time.present? && rent_time.past?)
      errors.add(:rent_time, "can't be in the past")
    else
      if (return_time.present? && return_time.past?)
        errors.add(:return_time, "can't be in the past")
      end
    end
  end

  def return_time_cannot_be_in_the_rent_time
    if rent_time.present? && return_time.present? && return_time <= rent_time
      errors.add(:return_time, "can't be in the rent_time")
    end
  end
end

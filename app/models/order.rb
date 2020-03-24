class Order < ApplicationRecord
  belongs_to :user
  belongs_to :car
  default_scope -> { order(created_at: :desc) }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :phone, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }
  validate :checkin_time_cannot_be_in_the_past
  validate :return_time_cannot_be_in_the_rent_time
  validates :rent_time, presence: true
  validates :return_time, presence: true
  enum orders_status: { requesting: "requesting", approved: "approved", finished: "finished", deny: "deny" }
  validates :orders_status, presence: true, inclusion: { in: %w(requesting approved finished deny) }

  private

  def checkin_time_cannot_be_in_the_past
    if rent_time.present? && rent_time.past? && return_time.present? && return_time.past?
      errors.add(:rent_time, "can't be in the past")
      errors.add(:return_time, "can't be in the past")
    end
  end

  def return_time_cannot_be_in_the_rent_time
    if rent_time.present? && return_time.present? && return_time <= rent_time
      errors.add(:return_time, "can't be in the rent_time")
    end
  end
end

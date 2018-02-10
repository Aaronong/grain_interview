class DeliveryOrder < ApplicationRecord
  # model association
  has_many :order_items, dependent: :destroy
  has_one :feedback, as: :ratable

  # validations
  validates_presence_of :order_id, :serving_datetime
end

class DeliveryOrder < ApplicationRecord
  # model association
  has_many :order_items, dependent: :destroy

  # validations
  validates_presence_of :order_id, :serving_datetime
end

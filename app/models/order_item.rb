class OrderItem < ApplicationRecord
  # model association
  belongs_to :delivery_order
  belongs_to :meal
  has_one :feedback, as: :ratable

  # validations
  validates_presence_of :serving_date, :quantity, :unit_price
end

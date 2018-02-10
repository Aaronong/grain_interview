class Meal < ApplicationRecord
  # model association
  has_many :order_items, dependent: :destroy

  # validations
  validates_presence_of :name, :byline
end

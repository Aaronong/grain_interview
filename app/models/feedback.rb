class Feedback < ApplicationRecord
  # model association
  belongs_to :ratable, polymorphic: true

  # validations
  validates_presence_of :ratable_type, :rating, :comment
end

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  # Association test
  # ensure an OrderItem record belongs to a single Meal and DeliveryOrder record
  it { should belong_to(:delivery_order) }
  it { should belong_to(:meal) }
  # Validation tests
  # ensure that all required columns are present before saving
  it { should validate_presence_of(:serving_date) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit_price) }
end

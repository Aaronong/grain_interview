require 'rails_helper'

RSpec.describe DeliveryOrder, type: :model do
  # Association test
  # ensure Delivery model has a 1:m relationship with the OrderItem model
  it { should have_many(:order_items).dependent(:destroy) }
  # Validation tests
  # ensure that all required columns are present before saving
  it { should validate_presence_of(:order_id) }
  it { should validate_presence_of(:serving_datetime) }
end

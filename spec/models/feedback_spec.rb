require 'rails_helper'

RSpec.describe Feedback, type: :model do
  # Association test
  # ensure a Feedback record belongs to a single ratable record
  it { should belong_to(:ratable) }
  # Validation tests
  # ensure that all required columns are present before saving
  it { should validate_presence_of(:ratable_type) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:comment) }
end

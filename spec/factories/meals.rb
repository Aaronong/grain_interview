FactoryGirl.define do
  factory :meal do
    name { Faker::Food.dish }
    byline { Faker::Food.describe }
  end
end

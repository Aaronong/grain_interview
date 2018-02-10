FactoryGirl.define do
  factory :delivery_order do
    order_id { Faker::Bank.swift_bic }
    serving_datetime { Faker::Date.backward(14) }
  end
end

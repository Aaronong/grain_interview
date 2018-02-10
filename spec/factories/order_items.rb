FactoryGirl.define do
  factory :order_items do
    delivery_order_id nil
    serving_date { Faker::Date.backward(14) }
    meal_id nil
    quantity { Faker::Number.between(1, 5) }
    unit_price { Faker::Number.between(1, 100) }
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear the DB

OrderItem.delete_all
DeliveryOrder.delete_all
Meal.delete_all

# Create 10 meals
10.times do
  Meal.create(name: Faker::Food.dish, byline: Faker::Food.dish)
end

# Create a list of all valid meal ids
meal_ids = Meal.all.map(&:id)

# Create 5 delivery orders
5.times do
  order = DeliveryOrder.create(order_id: Faker::Bank.swift_bic, serving_datetime: Faker::Time.between(14.days.ago, Date.today, :all))
  Faker::Number.between(1, 5).times do
    chosen_meal_id = meal_ids.sample
    queried_order_item = order.order_items.all.detect { |item| item.meal_id == chosen_meal_id }
    if queried_order_item.nil?
      OrderItem.create(delivery_order_id: order.id, serving_date: Faker::Date.backward(14), meal_id: meal_ids.sample, quantity: Faker::Number.between(0, 1), unit_price: Faker::Number.between(100, 3000))
    else
      queried_order_item.quantity += 1
      queried_order_item.save
    end
  end
end

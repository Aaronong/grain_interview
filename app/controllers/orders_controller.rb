class OrdersController < ApplicationController
  # GET /orders
  def index
    set_orders
    json_response(@orders)
  end

  # GET /orders/:id
  def show
    set_order
    json_response(@order)
  end

  private

  def set_order
    raw_order = DeliveryOrder.find(params[:id])
    @order = {}
    @order[:order_id] = raw_order.order_id
    @order[:delivery_date] = raw_order.serving_datetime.to_date
    @order[:delivery_time] = datetime_to_time(raw_order.serving_datetime)
    @order[:order_items] = display_order_item(raw_order.order_items)
  end

  def set_orders
    @orders = DeliveryOrder.all.map do |order|
      processed_order = {}
      processed_order[:id] = order.id
      processed_order[:order_id] = order.order_id
      processed_order[:delivery_date] = order.serving_datetime.to_date
      processed_order[:delivery_time] = datetime_to_time(order.serving_datetime)
      processed_order[:feedback_submitted] = order.feedback.nil? ? false : true
      processed_order[:order_items] = display_general_order_item(order.order_items)
      processed_order
    end
  end

  def t_to_s(time)
    time.to_s.rjust(2, '0')
  end

  def datetime_to_time(datetime)
    startMins = datetime.min > 30 ? 30 : 0
    startHours = datetime.hour
    postfix = 'AM'
    if startHours > 12
      postfix = 'PM'
      startHours -= 12
    elsif startHours == 0
      startHours = 12
    elsif startHours == 12
      postfix = 'PM'
    end
    endMins = startMins == 30 ? 0 : 30
    endHours = startMins == 30 ? startHours + 1 : startHours
    if endHours > 12
      postfix = postfix == 'AM' ? 'PM' : 'AM'
      endHours -= 12
    end
    "#{t_to_s(startHours)}:#{t_to_s(startMins)}-#{t_to_s(endHours)}:#{t_to_s(endMins)}#{postfix}"
  end

  def display_order_item(order_items)
    order_items = order_items.map do |order|
      display_item = {}
      display_item[:name] = order.meal.name
      display_item[:quantity] = order.quantity
      display_item[:total_price] = order.quantity * order.unit_price
      display_item
    end

    order_items.select do |order|
      order[:quantity] > 0
    end
  end

  def display_general_order_item(order_items)
    order_items.map do |order|
      display_item = {}
      display_item[:order_item_id] = order.id
      display_item[:name] = order.meal.name
      display_item
    end
  end
end

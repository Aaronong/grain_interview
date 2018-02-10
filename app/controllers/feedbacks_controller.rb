class FeedbacksController < ApplicationController
  before_action :set_order

  # GET /orders/:order_id/feedbacks
  def index
    json_response(@feedback_list)
  end

  # POST /orders/:order_id/feedbacks
  def create
    feedback_params.each do |feedback|
      model = feedback[:ratable_type] == 'OrderItem' ? OrderItem : DeliveryOrder
      obj = model.find(feedback[:ratable_id])
      pp obj.feedback
      if obj.feedback.nil?
        Feedback.create(feedback)
      else
        obj.feedback.rating = feedback[:rating]
        obj.feedback.comment = feedback[:comment]
        obj.feedback.save
      end
    end
    json_response(feedback_params, :created)
  end

  private

  def feedback_params
    params[:feedbacks].map do |feedback|
      feedback.permit(:ratable_id, :ratable_type, :rating, :comment)
    end
  end

  def fb_slice(fb)
    fb.nil? ? nil : fb.slice(:ratable_id, :ratable_type, :rating, :comment)
  end

  def nil_or_append(itm)
    itm.nil? ? @feedback_list : @feedback_list << fb_slice(itm)
  end

  def set_order
    @delivery_order = DeliveryOrder.find(params[:order_id])
    @order_items = @delivery_order.order_items
    @feedback_list = []
    nil_or_append(@delivery_order.feedback)
    @order_items.each do |item|
      nil_or_append(item.feedback)
    end
  end
end

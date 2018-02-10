class OrdersController < ApplicationController
  before_action :set_todo, only: %i[show update destroy]

  # GET /orders
  def index
    @orders = DeliveryOrder.all
    json_response(@orders)
  end

  # GET /orders/:id
  def show
    json_response(@order)
  end

  private

  def set_todo
    @order = DeliveryOrder.find(params[:id])
  end
end

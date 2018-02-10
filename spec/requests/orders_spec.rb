require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  # initialize test data
  # let!(:meals) { FactoryGirl.create_list(:meal, 10) }
  # let(:meal_id) { meals.first.id }
  let!(:delivery_orders) { FactoryGirl.create_list(:delivery_order, 10) }
  let(:delivery_order_id) { 1 }
  # let!(:order_items) { FactoryGirl.create_list(:order_item, 10) }
  # let(:order_item_id) { order_items.first.id }

  # Test suite for GET /orders
  describe 'GET /orders' do
    # make HTTP get request before each example
    before { get '/orders' }

    it 'returns DeliveryOrders' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /orders/:id
  describe 'GET /orders/:id' do
    before { get "/orders/#{delivery_order_id}" }

    context 'when the record exists' do
      it 'returns the order' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(delivery_order_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:delivery_order_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DeliveryOrder/)
      end
    end
  end
end

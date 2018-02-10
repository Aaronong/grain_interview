require 'rails_helper'
require 'date'

def valid_date?(str, format = '%y-%d-%m')
  Date.parse(str, format)
  true
rescue StandardError
  false
end

RSpec.describe 'Orders API', type: :request do
  # initialize test data
  let!(:delivery_orders) { DeliveryOrder.all }
  let(:delivery_order_id) { delivery_orders.first.id }

  # Test suite for GET /orders
  describe 'GET /orders' do
    # make HTTP get request before each example
    before { get '/orders' }

    it 'returns DeliveryOrders' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'has properly formed data' do
      json.each do |row|
        expect(row['order_id']).not_to be_empty
        expect(valid_date?(row['delivery_date'])).to be true
        expect(row['delivery_time']).to match(/[0-1][0-9]:[0|3]0\-[0-1][0-9]:[0|3]0[A|P]M/)
      end
    end
  end

  # Test suite for GET /orders/:id
  describe 'GET /orders/:id' do
    before { get "/orders/#{delivery_order_id}" }

    context 'when the record exists' do
      it 'returns the order' do
        expect(json).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'has properly formed data' do
        expect(json['order_id']).not_to be_empty
        expect(valid_date?(json['delivery_date'])).to be true
        expect(json['delivery_time']).to match(/[0-1][0-9]:[0|3]0\-[0-1][0-9]:[0|3]0[A|P]M/)
        json['order_items'].each do |item|
          expect(item['name']).not_to be_empty
          expect(item['quantity']).to be > 0
          expect(item['total_price']).to be > 0
        end
      end
    end

    context 'when the record does not exist' do
      let(:delivery_order_id) { 1_000_000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DeliveryOrder/)
      end
    end
  end
end

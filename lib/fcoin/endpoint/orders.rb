require_relative 'utility'

# @see https://developer.fcoin.com/jp.html?javascript#32c808cbe5
# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Orders
      include Utility

      # POST https://api.fcoin.com/v2/orders
      # payload:
      # - symbol:      e.x) ethusdt
      # - side:             sell  or buy
      # - type:             limit or market
      # - price:
      # - amount:
      def create_order(symbol:, side:, type:, price:, amount:)
        payload = { symbol: symbol, side: side, type: type, price: price, amount: amount }
        valid_payload = sort_payload(payload)
        post('orders', true, valid_payload)
      end

      # GET https://api.fcoin.com/v2/orders
      def order_list(symbol:, states:, page_before: nil, page_after: nil, per_page: 20)
        params = { symbol: symbol, states: states, before: page_before, after: page_after, limit: per_page }
        valid_params = sort_params(params)
        get('orders', true, valid_params)
      end

      # GET https://api.fcoin.com/v2/orders/{order_id}
      def reference_order(order_id:)
        get("orders/#{order_id}")
      end
      alias :order :reference_order

      # POST https://api.fcoin.com/v2/orders/{order_id}/submit-cancel
      def cancel_order(order_id:)
        post("orders/#{order_id}/submit-cancel")
      end

      # GET https://api.fcoin.com/v2/orders/{order_id}/match-results
      def order_match_results(order_id:)
        get("orders/#{order_id}/match-results")
      end
      alias :order_transaction :order_match_results
    end
  end
end
require_relative 'utility'
require_relative '../validator'

# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Orders
      include Utility
      # Create order.
      #
      # curl: POST https://api.fcoin.com/v2/orders
      #
      # @note This method can not be invoked without authentication.
      #
      # @example Create an order to sell 0.010eth at a price of 1000usdt.
      #  client = Fcoin::Client.new(api_key: ENV['FCOIN_API_KEY'], secret_key: ENV['FCOIN_SECRET_KEY'])
      #  puts client.create_order(symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001) #=> {"status":0,"data":"R0moy92q4Qaf_G*********wwJM2bz_Zyacp-Ek8="}'
      #
      #
      # @see https://developer.fcoin.com/zh.html#4a3e521c3b
      # @raise [ArgumentError] If the symbol or side or type or price or amount does not have.
      # @raise [InvalidValueError] If symbol or side or type or price or amount is invalid.
      # @param symbol [String or Symbol] Transaction of pair
      # @param side [String or Symbol] Direction of the transaction
      # @param type [String or Symbol] Order type.
      # @param price [Float]
      # @param amount [Float]
      # @return [Hash] Returns receipt contains order_id.
      def create_order(symbol:, side:, type:, price:, amount:)
        payload = { symbol: symbol, side: side, type: type, price: price, amount: amount }
        validator = Fcoin::Validator.new(payload.merge(method_name: __method__))
        if skip_validation || validator.valid?
          valid_payload = sort_payload(payload)
          post('orders', true, valid_payload)
        else
          raise InvalidValueError.new(validator.messages)
        end
      end

      # Get order list.
      #
      # curl: GET https://api.fcoin.com/v2/orders
      #
      # @note This method can not be invoked without authentication.
      #
      # @example get the canceled　order list of ethusdt limit 20 per page.
      #  client = Fcoin::Client.new(api_key: ENV['FCOIN_API_KEY'], secret_key: ENV['FCOIN_SECRET_KEY'])
      #  puts client.order_list(symbol: :ethusdt, states: :canceled, page_before: nil, page_after: nil, per_page: 20) #=> {"status":0,"data":[{"id":"L7rbALEIoI0ymo3uOXBF4gT4BlyTxgHhGoZjvptIv2U=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531714218130,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"32ZZCBEpPz2J9oFIJ4RMTIbypltjrVD9PAdYxQTHhUE=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531714092732,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"VotO2IKI2opgyKRd1lhR5bYj9zNZ398IW85gcBNPisU=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531712709955,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"tYH6LczJxaVe_WhsLOzOk4YM53hK2q169nYn9ReiwGM=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531675732267,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"web","state":"canceled"},{"id":"U50WtZkmIh_bbuVKoipAMayCIy0A7qk4hBLxpDvKdPk=","symbol":"ethusdt","amount":"0.025800000000000000","price":"491.100000000000000000","created_at":1529665880201,"type":"limit","side":"buy","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"web","state":"canceled"}]}
      #
      #
      # @see https://developer.fcoin.com/zh.html#9094989d10
      # @raise [ArgumentError] If the symbol or states or per_page does not have.
      # @raise [InvalidValueError] If symbol or states or per_page is invalid.
      # @param symbol [String or Symbol] Transaction of pair.
      # @param states [String or Symbol] Order states. states must be incldued in [submitted, partial_filled, canceled, partial_canceled, filled, pending_cancel]
      # @param page_before [Integer] Query order before page number.
      # @param page_after [Integer] Query order after page number.
      # @param per_page [Integer] Order quantity per page. default is 20.
      # @return [Hash] Returns order list.
      def order_list(symbol:, states:, page_before: nil, page_after: nil, per_page: 20)
        params = { symbol: symbol, states: states.to_s, before: page_before, after: page_after, limit: per_page }
        validator = Fcoin::Validator.new(params.merge(method_name: __method__))
        if skip_validation || validator.valid?
          valid_params = sort_params(params)
          get('orders', true, valid_params)
        else
          raise InvalidValueError.new(validator.messages)
        end
      end

      # Query order.
      #
      # curl: GET https://api.fcoin.com/v2/orders/$order_id
      #
      # @note This method can not be invoked without authentication.
      #
      # @example query order specified by order_id.
      #  client = Fcoin::Client.new(api_key: ENV['FCOIN_API_KEY'], secret_key: ENV['FCOIN_SECRET_KEY'])
      #  puts client.reference_order(order_id: "L7rbALEIoI0ymo3uOXBF4gT4Bl********jvptIv2U=") #=> {"status":0,"data":{"id":"L7rbALEIoI0ymo3uOXBF4gT4BlyTxgHhGoZjvptIv2U=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531714218130,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"}}
      #
      #
      # @see https://developer.fcoin.com/zh.html#5faf03be01
      # @raise [ArgumentError] If the order_id does not have.
      # @param order_id [String]
      # @return [Hash] Returns order specified by order_id.
      def reference_order(order_id:)
        get("orders/#{order_id}")
      end
      alias :order :reference_order

      # Cancel order.
      #
      # curl: POST https://api.fcoin.com/v2/orders/$order_id/submit-cancel
      #
      # @note This method can not be invoked without authentication.
      #
      # @example cancel order specified by order_id.
      #  client = Fcoin::Client.new(api_key: ENV['FCOIN_API_KEY'], secret_key: ENV['FCOIN_SECRET_KEY'])
      #  puts client.cancel_order(order_id: "nMEC_VrW0LYlP4iCcWzmdL50jFrvNWZoaQxvZSjeUSA=") #=> {"status":0}
      #
      #
      # @see https://developer.fcoin.com/zh.html#299126e3bf
      # @raise [ArgumentError] If the order_id does not have.
      # @param order_id [String]
      # @return [Hash]
      def cancel_order(order_id:)
        post("orders/#{order_id}/submit-cancel")
      end

      # Query the transaction record for the specified by order_id.
      #
      # curl: GET https://api.fcoin.com/v2/orders/$order_id/match-results
      #
      # @note This method can not be invoked without authentication.
      #
      # @example Query the transaction record for the specified by order_id.
      #  client = Fcoin::Client.new(api_key: ENV['FCOIN_API_KEY'], secret_key: ENV['FCOIN_SECRET_KEY'])
      #  puts client.order_match_results(order_id: "kW3cRiXIGHG-cHNdter*********qfoMzbeHEQcqp4=") #=> {"status":0,"data":[{"price": "1000","fill_fees": "0.00010000000000000","filled_amount": "0.00500000000000000","side": "buy","type": "limit","created_at": 1531734385085}]}
      #
      #
      # @see https://developer.fcoin.com/zh.html#152112dfd6
      # @raise [ArgumentError] If the order_id does not have.
      # @param order_id [String]
      # @return [Hash] Returns transaction record for the specified by order_id.
      def order_match_results(order_id:)
        get("orders/#{order_id}/match-results")
      end
      alias :order_transaction :order_match_results
    end
  end
end
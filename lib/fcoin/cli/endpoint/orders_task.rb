require_relative '../../../fcoin'
require 'thor'

module Fcoin
  module EndPoint
    class OrdersTask < Thor
      # Create limit order
      #
      # curl: POST https://api.fcoin.com/v2/orders
      #
      # @note This method can not be invoked without authentication.
      #
      # @example Create an order to sell 0.010eth at a price of 1000usdt.
      #  export FCOIN_API_KEY='your_fcoin_api_key'
      #  export FCOIN_SECRET_KEY='your_fcoin_secret_key'
      #  ./bin/fcoin order create_limit --symbol ethusdt --side sell --price 1000 --amount 0.001
      #
      #
      # @see https://developer.fcoin.com/zh.html#4a3e521c3b
      # @raise [ArgumentError] If the symbol or side or type or price or amount does not have.
      # @raise [InvalidValueError] If symbol or side or type or price or amount is invalid.
      # @param symbol [String] Transaction of pair.
      # @param side [String] Direction of the transaction.
      # @param type [String] Order type.
      # @param price [Float]
      # @param amount [Float]
      # @return [JSON] Returns receipt contains order_id.
      desc 'create_limit', 'Create limit order'
      option :symbol, type: :string,  required: true, desc: 'Transaction of pair'
      option :side,   type: :string,  required: true, desc: 'Direction of the transaction'
      option :price,  type: :numeric, required: true
      option :amount, type: :numeric, required: true
      def create_limit
        symbol = options[:symbol]
        side   = options[:side]
        type   = :limit
        price  = options[:price]
        amount = options[:amount]
        STDOUT.puts client.create_order_limit(symbol: symbol, side: side, type: type, price: price, amount: amount)
      end

      # Get order list.
      #
      # curl: GET https://api.fcoin.com/v2/orders
      #
      # @note This method can not be invoked without authentication.
      #
      # @example get the canceled　order list of ethusdt limit 20 per page.
      #  export FCOIN_API_KEY='your_fcoin_api_key'
      #  export FCOIN_SECRET_KEY='your_fcoin_secret_key'
      #  ./bin/fcoin order_list --symbol ethusdt, --states canceled --per_page 20
      #
      #
      # @see https://developer.fcoin.com/zh.html#9094989d10
      # @raise [ArgumentError] If the symbol or states or per_page does not have.
      # @raise [InvalidValueError] If symbol or states or per_page is invalid.
      # @param symbol [String] Transaction of pair.
      # @param states [String] Order states. states must be incldued in [submitted, partial_filled, canceled, partial_canceled, filled, pending_cancel]
      # @param page_before [Integer] Query order before page number.
      # @param page_after [Integer] Query order after page number.
      # @param per_page [Integer] Order quantity per page. default is 20.
      # @return [JSON] Returns order list.
      desc 'list', 'Get order list'
      option :symbol,      type: :string,  required: true, desc: 'Transaction of pair'
      option :states,      type: :string,  required: true, desc: 'Order states. states must be incldued in [submitted, partial_filled, canceled, partial_canceled, filled, pending_cancel]'
      option :page_before, type: :numeric,                 desc: 'Query order before page number', default: nil
      option :page_after,  type: :numeric,                 desc: 'Query order after page number',  default: nil
      option :per_page,    type: :numeric,                 desc: 'Order quantity per page', default: 20
      def list
        symbol      = options[:symbol]
        states      = options[:states]
        page_before = options[:page_before]
        page_after  = options[:page_after]
        per_page    = options[:per_page]
        STDOUT.puts client.order_list(symbol: symbol, states: states, page_before: page_before, page_after: page_after, per_page: per_page)
      end

      # Query order.
      #
      # curl: GET https://api.fcoin.com/v2/orders/$order_id
      #
      # @note This method can not be invoked without authentication.
      #
      # @example query order specified by order_id.
      #  export FCOIN_API_KEY='your_fcoin_api_key'
      #  export FCOIN_SECRET_KEY='your_fcoin_secret_key'
      #  ./bin/fcoin order --order_id L7rbALEIoI0ymo3uOXBF4gT4Bl********jvptIv2U=
      #
      #
      # @see https://developer.fcoin.com/zh.html#5faf03be01
      # @raise [ArgumentError] If the order_id does not have.
      # @param order_id [String]
      # @return [JSON] Returns order specified by order_id.
      desc 'reference', 'Ouery order'
      option :order_id, type: :string, required: true
      def reference
        order_id = options[:order_id]
        STDOUT.puts client.order(order_id: order_id)
      end

      # Cancel order.
      #
      # curl: POST https://api.fcoin.com/v2/orders/$order_id/submit-cancel
      #
      # @note This method can not be invoked without authentication.
      #
      # @example cancel order specified by order_id.
      #  export FCOIN_API_KEY='your_fcoin_api_key'
      #  export FCOIN_SECRET_KEY='your_fcoin_secret_key'
      #  ./bin/fcoin cancel_order --order_id nMEC_VrW0LYlP4iCcWzmdL50jFrvNWZoaQxvZSjeUSA=
      #
      #
      # @see https://developer.fcoin.com/zh.html#299126e3bf
      # @raise [ArgumentError] If the order_id does not have.
      # @param order_id [String]
      # @return [JSON]
      desc 'cancel', 'Cancel order'
      option :order_id, type: :string, required: true
      def cancel
        order_id = options[:order_id]
        STDOUT.puts client.cancel_order(order_id: order_id)
      end

      # Query the transaction record for the specified by order_id.
      #
      # curl: GET https://api.fcoin.com/v2/orders/$order_id/match-results
      #
      # @note This method can not be invoked without authentication.
      #
      # @example Query the transaction record for the specified by order_id.
      #  export FCOIN_API_KEY='your_fcoin_api_key'
      #  export FCOIN_SECRET_KEY='your_fcoin_secret_key'
      #  ./bin/fcoin order_transaction --order_id kW3cRiXIGHG-cHNdter*********qfoMzbeHEQcqp4=
      #
      #
      # @see https://developer.fcoin.com/zh.html#152112dfd6
      # @raise [ArgumentError] If the order_id does not have.
      # @param order_id [String]
      # @return [JSON] Returns transaction record for the specified by order_id.
      desc 'transaction', 'Query the transaction record for the specified by order_id'
      option :order_id, type: :string, required: true
      def transaction
        order_id = options[:order_id]
        STDOUT.puts client.order_transaction(order_id: order_id)
      end

      private

      # TODO: After checking the operation, go to the public
      #
      # Create market order
      #
      # curl: POST https://api.fcoin.com/v2/orders
      #
      # @note This method can not be invoked without authentication.
      #
      # @example Create an order to sell 0.010eth at a price of 1000usdt.
      #  export FCOIN_API_KEY='your_fcoin_api_key'
      #  export FCOIN_SECRET_KEY='your_fcoin_secret_key'
      #  ./bin/fcoin order create_market --symbol ethusdt --side sell  --amount 0.001
      #
      #
      # @see https://developer.fcoin.com/zh.html#4a3e521c3b
      # @raise [ArgumentError] If the symbol or side or type or price or amount does not have.
      # @raise [InvalidValueError] If symbol or side or type or price or amount is invalid.
      # @param symbol [String] Transaction of pair
      # @param side [String] Direction of the transaction
      # @param type [String] Order type
      # @param amount [Float] This is valid if side is sell
      # @param total [Float] This is valid if side is buy
      # @return [JSON] Returns receipt contains order_id
      desc 'create_market', 'Create market order'
      option :symbol, type: :string,  required: true, desc: 'Transaction of pair'
      option :side,   type: :string,  required: true, desc: 'Direction of the transaction'
      option :amount, type: :numeric
      option :total,  type: :numeric
      def create_market
        symbol = options[:symbol]
        side   = options[:side]
        type   = :market
        amount = options[:amount]
        total  = options[:total]
        case side.to_sym
        when :sell
          STDOUT.puts client.create_order_market(symbol: symbol, side: side, type: type, amount: amount)
        when :buy
          STDOUT.puts client.create_order_market(symbol: symbol, side: side, type: type, total: total)
        end
      end

      def client
        Fcoin::Client.new
      end
    end
  end
end

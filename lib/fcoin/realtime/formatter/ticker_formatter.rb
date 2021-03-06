require_relative 'base_formatter'

module Fcoin
  module RealTime
    class TickerFormatter < BaseFormatter

      attr_accessor :data
      
      def initialize(data)
        self.data = data
      end

      # Format response data for JSON
      #
      # @return [Hash]
      def formatted_data
        # https://developer.fcoin.com/en.html
        ticker = data['ticker'].dup
        self.data['ticker'] = {
                             "latest_price" => ticker[0],
                             "most_recent_trade_vol" => ticker[1],
                             "max_buy_price" => ticker[2],
                             "max_buy_amount" => ticker[3],
                             "min_sell_price" => ticker[4],
                             "min_sell_amount" => ticker[5],
                             "trade_price_yesterday" => ticker[6],
                             "highest_price_today" => ticker[7],
                             "lowest_price_today" => ticker[8],
                             "symbol_base_vol_today" => ticker[9],
                             "symbol_base_price_today" => ticker[10]
                         }
        data
      end
    end
  end
end

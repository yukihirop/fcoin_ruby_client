require_relative 'utility'

# @see https://developer.fcoin.com/jp.html?javascript#32c808cbe5
# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Market
      # GET https://api.fcoin.com/v2/market/ticker/$symbol
      def market_ticker(symbol:)
        get("market/ticker/#{symbol}", false)
      end

      # GET https://api.fcoin.com/v2/market/depth/$level/$symbol
      def market_depth(symbol:, level:)
        if valid_level?(level)
          get("market/depth/#{level}/#{symbol}", false)
        else
          raise InvalidValueError.new("Invalid value level: #{level}.\nPlease input L20, L100 or full.")
        end
      end

      # GET https://api.fcoin.com/v2/market/trades/$symbol
      def market_trades(symbol:)
        get("market/trades/#{symbol}", false)
      end

      # GET https://api.fcoin.com/v2/market/candles/$resolution/$symbol
      def market_candles(symbol:, resolution:)
        if valid_resolution?(resolution)
          get("market/candles/#{resolution}/#{symbol}", false)
        else
          raise InvalidValueError.new("Invalid value resolution: #{resolution}.\nPlease input M1, M3, M5, M15, M30, H1, H4, H6, D1, W1 or MN.")
        end
      end

      private

      def valid_level?(level)
        valid_levels = %w(L20 L100 full) + %i(L20 L100 full)
        level.in? valid_levels
      end

      def valid_resolution?(resolution)
        valid_resolutions = %w(M1 M3 M5 M15 M30 H1 H4 H6 D1 W1 MN) + %i(M1 M3 M5 M15 M30 H1 H4 H6 D1 W1 MN)
        resolution.in? valid_resolutions
      end
    end
  end
end

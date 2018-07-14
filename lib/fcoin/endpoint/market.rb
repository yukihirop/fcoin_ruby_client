# @see https://developer.fcoin.com/jp.html?javascript#32c808cbe5
# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Market
      # GET https://api.fcoin.com/v2/market/ticker/$symbol
      def market_ticker(required={})
        required_missing_error(required, :symbol)
        symbol = required[:symbol]
        get("market/ticker/#{symbol}")
      end

      # GET https://api.fcoin.com/v2/market/depth/$level/$symbol
      def market_depth(required={})
        required_missing_error(required, :level, :symbol)
        level = required[:level]

        if valid_level?(level)
          symbol = required[:symbol]
          get("market/depth/#{level}/#{symbol}")
        else
          raise InvalidValueError.new("Invalid value level: #{level}.\nPlease input L20, L100 or full.")
        end
      end

      # GET https://api.fcoin.com/v2/market/trades/$symbol
      def market_trades(required={})
        required_missing_error(required, :symbol)
        symbol = required[:symbol]
        get("market/trades/#{symbol}")
      end

      # GET https://api.fcoin.com/v2/market/candles/$resolution/$symbol
      def market_candles(required={})
        required_missing_error(required, :resolution, :symbol)
        resolution = required[:resolution]
        
        if valid_resolution?(resolution)
          symbol = required[:symbol]
          get("market/candles/#{resolution}/#{symbol}")
        else
          raise InvalidValueError.new("Invalid value resolution: #{resolution}.\nPlease input M1, M3, M5, M15, M30, H1, H4, H6, D1, W1 or MN.")
        end
      end

      private

      def required_missing_error(required, *required_keys)
        required_keys.each do |key|
          raise ArgumentError.new("Required arguments :#{key.to_s} missing") if required[key].nil?
        end
      end

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

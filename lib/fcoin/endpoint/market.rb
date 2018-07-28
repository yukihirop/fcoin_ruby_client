require_relative 'utility'
require_relative '../validator'

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
        validator = Fcoin::Validator.build(level: level, method_name: __method__)
        if validator.valid?
          get("market/depth/#{level}/#{symbol}", false)
        else
          raise InvalidValueError.new validator.messages
        end
      end

      # GET https://api.fcoin.com/v2/market/trades/$symbol
      def market_trades(symbol:)
        get("market/trades/#{symbol}", false)
      end

      # GET https://api.fcoin.com/v2/market/candles/$resolution/$symbol
      def market_candles(symbol:, resolution:)
        validator = Fcoin::Validator.build(resolution: resolution, method_name: __method__)
        if validator.valid?
          get("market/candles/#{resolution}/#{symbol}", false)
        else
          raise InvalidValueError.new validator.messages
        end
      end
    end
  end
end

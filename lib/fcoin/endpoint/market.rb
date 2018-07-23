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
        validation = validation(__method__, level: level)
        if validation.success?
          get("market/depth/#{level}/#{symbol}", false)
        else
          raise InvalidValueError.new(validation.messages[:level].first)
        end
      end

      # GET https://api.fcoin.com/v2/market/trades/$symbol
      def market_trades(symbol:)
        get("market/trades/#{symbol}", false)
      end

      # GET https://api.fcoin.com/v2/market/candles/$resolution/$symbol
      def market_candles(symbol:, resolution:)
        validation = validation(__method__, resolution: resolution)
        if validation.success?
          get("market/candles/#{resolution}/#{symbol}", false)
        else
          raise InvalidValueError.new(validation.messages[:resolution].first)
        end
      end
    end
  end
end

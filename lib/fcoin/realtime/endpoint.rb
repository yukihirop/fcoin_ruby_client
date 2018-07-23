require_relative 'wss'

# Scope Fcoin::RealTime::API
module Fcoin
  module RealTime
    module EndPoint
      include Fcoin::RealTime::WSS

      def on_ticker(symbol:, &block)
        on("ticker.#{symbol}", nil, &block)
      end

      def on_depth(symbol:, level:, &block)
        if valid_level?(level)
          on("depth.#{level}.#{symbol}", nil, &block)
        else
          raise InvalidValueError.new("Invalid value level: #{level}.\nPlease input L20, L100 or full.")
        end
      end

      def on_trade(symbol:, limit: 20, &block)
        on("trade.#{symbol}", limit, &block)
      end

      def on_candle(symbol:, resolution:, limit: 20, &block)
        if valid_resolution?(resolution)
          on("candle.#{resolution}.#{symbol}", limit, &block)
        else
          raise InvalidValueError.new("Invalid value resolution: #{resolution}.\nPlease input M1, M3, M5, M15, M30, H1, H4, H6, D1, W1 or MN.")
        end
      end

      def on_topics(&block)
        on('topics', nil, &block)
      end

      def on_hello(&block)
        on('hello', nil, &block)
      end
    end
  end
end

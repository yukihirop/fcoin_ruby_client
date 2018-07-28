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
        validator = Fcoin::Validator.build(symbol: symbol, level: level, method_name: __method__)
        if skip_validation || validator.valid?
          on("depth.#{level}.#{symbol}", nil, &block)
        else
          raise InvalidValueError.new(validator.messages)
        end
      end

      def on_trade(symbol:, limit: 20, &block)
        on("trade.#{symbol}", limit, &block)
      end

      def on_candle(symbol:, resolution:, limit: 20, &block)
        validator = Fcoin::Validator.build(symbol: symbol, resolution: resolution, method_name: __method__)
        if skip_validation || validator.valid?
          on("candle.#{resolution}.#{symbol}", limit, &block)
        else
          raise InvalidValueError.new(validator.messages)
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

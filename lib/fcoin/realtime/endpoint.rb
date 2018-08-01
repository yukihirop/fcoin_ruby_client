require_relative 'wss'

# Scope Fcoin::RealTime::API
module Fcoin
  module RealTime
    module EndPoint
      include Fcoin::RealTime::WSS
      # Subscribe to ticker information
      #
      # @note Please be sure to call client.subscribe at the end
      #
      # @example Subscribe to ticker information of ethusdt
      #  client = Fcoin::Client.new.realtime
      #  # client = Fcoin::RealTime::Client.new
      #  client.on_ticker(symbol: :ethusdt) do |data|
      #    puts data
      #  end
      #  client.subscribe
      #  #=> {"ticker"=>{"latest_price"=>464.14, "most_recent_trade_vol"=>0.0046, "max_buy_price"=>464.12, "max_buy_amount"=>0.8, "min_sell_price"=>464.14, "min_sell_amount"=>0.5154, "trade_price_yesterday"=>468.09, "highest_price_today"=>471.79, "lowest_price_today"=>461.29, "symbol_base_vol_today"=>51512.752914829, "symbol_base_price_today"=>23993418.702288836}, "type"=>"ticker.ethusdt", "seq"=>100851177}
      #  #=> ...
      #
      #
      # @see https://developer.fcoin.com/zh.html#ticker
      # @raise [ArgumentError] If the symbol does not have.
      # @param symbol [String or Symbol] Transaction pair
      # @yieldreturn Process block arguments
      def on_ticker(symbol:, &block)
        on("ticker.#{symbol}", nil, &block)
      end

      # Subscribe to depth information
      #
      # @note Please be sure to call client.subscribe at the end
      #
      # @example Subscribe to depth information of ethusdt specified by L20 level
      #  client = Fcoin::Client.new.realtime
      #  # client = Fcoin::RealTime::Client.new
      #  client.on_depth(symbol: :ethusdt, level: :L20) do |data|
      #    puts data
      #  end
      #  client.subscribe
      #  #=> {"bids"=>[{"price"=>460.49, "amount"=>0.1892}, {"price"=>460.48, "amount"=>0.05}, {"price"=>460.43, "amount"=>0.01}, {"price"=>460.41, "amount"=>0.6826}, {"price"=>460.4, "amount"=>0.01}, {"price"=>460.39, "amount"=>0.0203}, {"price"=>460.37, "amount"=>0.0174}, {"price"=>460.34, "amount"=>0.035}, {"price"=>460.31, "amount"=>0.5836}, {"price"=>460.28, "amount"=>0.2341}, {"price"=>460.27, "amount"=>0.01}, {"price"=>460.26, "amount"=>0.2984}, {"price"=>460.25, "amount"=>0.03}, {"price"=>460.22, "amount"=>0.0029}, {"price"=>460.21, "amount"=>0.11}, {"price"=>460.2, "amount"=>0.02}, {"price"=>460.19, "amount"=>0.02}, {"price"=>460.14, "amount"=>0.4256}, {"price"=>460.12, "amount"=>2.6374}, {"price"=>460.11, "amount"=>0.1}], "asks"=>[{"price"=>460.5, "amount"=>1.3892}, {"price"=>460.52, "amount"=>0.0851}, {"price"=>460.55, "amount"=>0.02}, {"price"=>460.57, "amount"=>0.0126}, {"price"=>460.6, "amount"=>23.664678116}, {"price"=>460.63, "amount"=>0.006}, {"price"=>460.64, "amount"=>0.0174}, {"price"=>460.65, "amount"=>0.03}, {"price"=>460.66, "amount"=>0.05}, {"price"=>460.67, "amount"=>0.04}, {"price"=>460.68, "amount"=>0.01}, {"price"=>460.7, "amount"=>0.02}, {"price"=>460.72, "amount"=>0.0528}, {"price"=>460.73, "amount"=>0.07}, {"price"=>460.74, "amount"=>0.12}, {"price"=>460.75, "amount"=>0.03}, {"price"=>460.76, "amount"=>0.01}, {"price"=>460.77, "amount"=>0.03}, {"price"=>460.78, "amount"=>0.01}, {"price"=>460.79, "amount"=>0.05}], "ts"=>1532951053012, "seq"=>101655772, "type"=>"depth.L20.ethusdt"}
      #  #=> ...
      #
      #
      # @see https://developer.fcoin.com/zh.html#50f4407ea4
      # @raise [ArgumentError] If the symbol or level does not have.
      # @raise [InvalidValueError] If symbol or level is invalid.
      # @param symbol [String or Symbol] Transaction pair
      # @param level [String or Symbol] Level of depth chart. level must be included in [L20, L40, full]
      # @yieldreturn Process block arguments
      def on_depth(symbol:, level:, &block)
        validator = Fcoin::Validator.new(symbol: symbol, level: level, method_name: __method__)
        if skip_validation || validator.valid?
          on("depth.#{level}.#{symbol}", nil, &block)
        else
          raise InvalidValueError.new(validator.messages)
        end
      end

      # Subscribe to trade information
      #
      # @note Please be sure to call client.subscribe at the end
      #
      # @example Subscribe to trade information of ethusdt limit 5
      #  client = Fcoin::Client.new.realtime
      #  # client = Fcoin::RealTime::Client.new
      #  client.on_trade(symbol: :ethusdt, limit: 5) do |data|
      #    puts data
      #  end
      #  client.subscribe
      #  #=> {"amount"=>0.002, "type"=>"trade.ethusdt", "ts"=>1532951759502, "id"=>101661132001, "side"=>"sell", "price"=>461.31}
      #  #=> {"amount"=>0.0063, "type"=>"trade.ethusdt", "ts"=>1532951771509, "id"=>101661197000, "side"=>"buy", "price"=>461.33}
      #  #=> ...
      #
      #
      # @see https://developer.fcoin.com/zh.html#6477a1394e
      # @raise [ArgumentError] If the symbol or level does not have.
      # @raise [InvalidValueError] If symbol or level is invalid.
      # @param symbol [String or Symbol] Transaction pair
      # @param limit [Integer]
      # @yieldreturn Process block arguments
      def on_trade(symbol:, limit: 20, &block)
        on("trade.#{symbol}", limit, &block)
      end

      # Subscribe to candle information
      #
      # @note Please be sure to call client.subscribe at the end
      #
      # @example Subscribe to candle information of ethusdt limit 5
      #  client = Fcoin::Client.new.realtime
      #  # client = Fcoin::RealTime::Client.new
      #  client.on_candle(symbol: :ethusdt, resolution: :MN, limit: 5) do |data|
      #    puts data
      #  end
      #  client.subscribe
      #  #=> {"open"=>449.1, "type"=>"candle.MN.ethusdt", "close"=>461.52, "high"=>516.09, "quote_vol"=>1440332504.2648032, "id"=>1530374400, "count"=>6300632, "low"=>418.29, "seq"=>10166589200000, "base_vol"=>3122587.167240264}
      #  #=> {"open"=>449.1, "type"=>"candle.MN.ethusdt", "close"=>461.52, "high"=>516.09, "quote_vol"=>1440332527.3408031, "id"=>1530374400, "count"=>6300633, "low"=>418.29, "seq"=>10166601500000, "base_vol"=>3122587.217240264}
      #  #=> ...
      #
      #
      # @see https://developer.fcoin.com/zh.html#candle
      # @raise [ArgumentError] If the symbol or resolution does not have.
      # @raise [InvalidValueError] If symbol or resolution is invalid.
      # @param symbol [String or Symbol] Transaction pair
      # @param resolution [String or Symbol] period of candles chart. resolution must be included in [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN]
      # @param limit [Integer]
      # @yieldreturn Process block arguments
      def on_candle(symbol:, resolution:, limit: 20, &block)
        validator = Fcoin::Validator.new(symbol: symbol, resolution: resolution, method_name: __method__)
        if skip_validation || validator.valid?
          on("candle.#{resolution}.#{symbol}", limit, &block)
        else
          raise InvalidValueError.new(validator.messages)
        end
      end

      # Subscribe to topics
      #
      # @note Please be sure to call client.subscribe at the end
      #
      # @example Subscribe to topics
      #  client = Fcoin::Client.new.realtime
      #  # client = Fcoin::RealTime::Client.new
      #  client.on_ticker(symbol: :ethusdt) do
      #  end
      #  client.on_topics do |data|
      #    puts data
      #  end
      #  client.subscribe
      #  #=> {"id"=>"f44a05d5-9a10-4fed-8719-6b8269cc13ce", "type"=>"topics", "topics"=>["ticker.ethusdt"]}
      #
      #
      # @yieldreturn Process block arguments
      def on_topics(&block)
        on('topics', nil, &block)
      end

      # Subscribe to server time
      #
      # @note Please be sure to call client.subscribe at the end
      #
      # @example Subscribe to Subscribe to server time
      #  client = Fcoin::Client.new.realtime
      #  # client = Fcoin::RealTime::Client.new
      #  client.on_hello do |data|
      #    puts data
      #  end
      #  client.subscribe
      #  #=> {"type"=>"hello", "ts"=>1532953247264}
      #
      #
      # @yieldreturn Process block arguments
      def on_hello(&block)
        on('hello', nil, &block)
      end
    end
  end
end

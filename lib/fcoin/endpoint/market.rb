require_relative 'utility'
require_relative '../validator'

# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Market
      # Returns ticker info of symbol.
      #
      # curl: GET https://api.fcoin.com/v2/market/ticker/$symbol
      #
      # @example get ethusdt ticker info
      #  client = Fcoin::Client.new
      #  puts client.market_ticker(symbol: :ethusdt) #=> {"status"=>0, "data"=>{"ticker"=>{"latest_price"=>469.43, "most_recent_trade_vol"=>0.002, "max_buy_price"=>469.43, "max_buy_amount"=>7.6318, "min_sell_price"=>469.44, "min_sell_amount"=>0.0011, "trade_price_yesterday"=>468.75, "highest_price_today"=>472.0, "lowest_price_today"=>461.76, "symbol_base_vol_today"=>44442.419672207, "symbol_base_price_today"=>20784202.592831347}, "type"=>"ticker.ethusdt", "seq"=>100521295}}
      #
      #
      # @see https://developer.fcoin.com/zh.html#ticker
      # @raise [ArgumentError] If the symbol does not have.
      # @param symbol [String or Symbol] a text string with the name of the current financial instrument.
      # @return [Hash] Returns ticker info.
      def market_ticker(symbol:)
        get("market/ticker/#{symbol}", false)
      end

      # Returns depth info of symbol specified by level.
      #
      # curl: GET https://api.fcoin.com/v2/market/depth/$level/$symbol
      #
      # @example get ethusdt depth info specified by L20 level.
      #  client = Fcoin::Client.new
      #  puts client.market_ticker(symbol: :ethusdt, level: :L20) #=> {"status"=>0, "data"=>{"bids"=>[{"price"=>468.16, "amount"=>0.009}, {"price"=>468.15, "amount"=>0.0077}, {"price"=>468.14, "amount"=>0.02}, {"price"=>468.1, "amount"=>0.3723}, {"price"=>468.09, "amount"=>0.1268}, {"price"=>468.07, "amount"=>0.02}, {"price"=>468.03, "amount"=>0.0025}, {"price"=>468.02, "amount"=>0.01}, {"price"=>468.0, "amount"=>0.0896}, {"price"=>467.97, "amount"=>0.9827}, {"price"=>467.83, "amount"=>0.01}, {"price"=>467.81, "amount"=>0.01}, {"price"=>467.8, "amount"=>0.04}, {"price"=>467.78, "amount"=>0.0146}, {"price"=>467.77, "amount"=>0.0016}, {"price"=>467.76, "amount"=>0.01}, {"price"=>467.75, "amount"=>0.01}, {"price"=>467.74, "amount"=>0.01}, {"price"=>467.73, "amount"=>0.4237}, {"price"=>467.72, "amount"=>0.01}], "asks"=>[{"price"=>468.22, "amount"=>0.7}, {"price"=>468.26, "amount"=>0.7}, {"price"=>468.28, "amount"=>0.5952}, {"price"=>468.56, "amount"=>0.0027}, {"price"=>468.57, "amount"=>0.9921}, {"price"=>468.58, "amount"=>0.06}, {"price"=>468.59, "amount"=>0.3599}, {"price"=>468.6, "amount"=>30.57797087}, {"price"=>468.61, "amount"=>0.01}, {"price"=>468.62, "amount"=>0.003}, {"price"=>468.63, "amount"=>0.005}, {"price"=>468.64, "amount"=>0.03}, {"price"=>468.67, "amount"=>0.0031}, {"price"=>468.68, "amount"=>0.3966}, {"price"=>468.7, "amount"=>0.05}, {"price"=>468.71, "amount"=>0.1}, {"price"=>468.74, "amount"=>0.01}, {"price"=>468.75, "amount"=>0.0021}, {"price"=>468.76, "amount"=>0.0046}, {"price"=>468.77, "amount"=>0.0023}], "ts"=>1532831776008, "seq"=>100535850, "type"=>"depth.L20.ethusdt"}}
      #
      #
      # @see https://developer.fcoin.com/zh.html#50f4407ea4
      # @raise [ArgumentError] If the symbol or level does not have.
      # @raise [InvalidValueError] If symbol or level is invalid.
      # @param symbol [String or Symbol] a text string with the name of the current financial instrument.
      # @param level [String or Symbol] Level of depth chart. level must be included in [L20, L40, full].
      # @return [Hash] Returns depth info.
      def market_depth(symbol:, level:)
        validator = Fcoin::Validator.build(level: level, method_name: __method__)
        if skip_validation || validator.valid?
          get("market/depth/#{level}/#{symbol}", false)
        else
          raise InvalidValueError.new validator.messages
        end
      end

      # Returns trades info of symbol.
      #
      # curl: GET https://api.fcoin.com/v2/market/trades/$symbol
      #
      # @example get ethusdt trades info.
      #  client = Fcoin::Client.new
      #  puts client.market_trades(symbol: :ethusdt) #=> {"status"=>0, "data"=>[{"amount"=>0.1811, "ts"=>1532832312857, "id"=>100541250000, "side"=>"buy", "price"=>467.95}]}
      #
      #
      # @see https://developer.fcoin.com/zh.html#6477a1394e
      # @raise [ArgumentError] If the symbol does not have.
      # @param symbol [String] a text string with the name of the current financial instrument.
      # @return [Hash] Returns trades info.
      def market_trades(symbol:)
        get("market/trades/#{symbol}", false)
      end

      # Returns candles info of symbol specified by resolution.
      #
      # curl: GET https://api.fcoin.com/v2/market/candles/$resolution/$symbol
      #
      # @example get monthly(MN) ethusdt candles info.
      #  client = Fcoin::Client.new
      #  puts client.market_candles(symbol: :ethusdt, resolution: :D1) #=> {"status"=>0, "data"=>[{"open"=>449.1, "close"=>467.67, "high"=>516.09, "quote_vol"=>1403153842.5110748, "id"=>1530374400, "count"=>6058571, "low"=>418.29, "seq"=>10055429000001, "base_vol"=>3042620.012726224}, {"id"=>1527782400, "seq"=>7385778300000, "high"=>555.13, "low"=>406.11, "open"=>523.97, "close"=>449.04, "count"=>20382481, "base_vol"=>28258854.226292703, "quote_vol"=>13579650310.735054}, {"id"=>1525104000, "seq"=>2847062700000, "high"=>582.99, "low"=>559.66, "open"=>563.23, "close"=>575.77, "count"=>4617, "base_vol"=>4159.317883344, "quote_vol"=>2380070.431548223}]}
      #
      #
      # @see https://developer.fcoin.com/zh.html#candle
      # @raise [ArgumentError] If the symbol or resolution does not have.
      # @raise [InvalidValueError] If symbol or resolution is invalid.
      # @param symbol [String or Symbol] a text string with the name of the current financial instrument.
      # @param resolution [String or Symbol] period of candles chart. resolution must be included in [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN].
      # @return [Hash] Returns candles info.
      def market_candles(symbol:, resolution:)
        validator = Fcoin::Validator.build(resolution: resolution, method_name: __method__)
        if skip_validation || validator.valid?
          get("market/candles/#{resolution}/#{symbol}", false)
        else
          raise InvalidValueError.new validator.messages
        end
      end
    end
  end
end

require_relative '../../../fcoin'
require 'thor'

module Fcoin
  module EndPoint
    class MarketTask < Thor
      # Returns ticker info of symbol.
      #
      # curl: GET https://api.fcoin.com/v2/market/ticker/$symbol
      #
      # @example get ethusdt ticker info
      #  ./exe/fcoin market ticker --symbol ethusdt
      #
      #
      # @see https://developer.fcoin.com/zh.html#ticker
      # @raise [ArgumentError] If the symbol does not have.
      # @param symbol [String] Transaction pairs.
      # @return [JSON] Returns ticker info.
      desc 'ticker', 'Returns ticker info of symbol'
      option :symbol, type: :string, required: true, desc: 'Transaction pairs'
      def ticker
        symbol = options[:symbol]
        STDOUT.puts client.market_ticker(symbol: symbol)
      end

      # Returns depth info of symbol specified by level.
      #
      # curl: GET https://api.fcoin.com/v2/market/depth/$level/$symbol
      #
      # @example get ethusdt depth info specified by L20 level.
      #  ./exe/fcoin market depth --symbol ethusdt --level L20
      #
      #
      # @see https://developer.fcoin.com/zh.html#50f4407ea4
      # @raise [ArgumentError] If the symbol or level does not have.
      # @raise [InvalidValueError] If symbol or level is invalid.
      # @param symbol [String] Transaction pairs.
      # @param level [String] Level of depth chart. level must be included in [L20, L40, full].
      # @return [JSON] Returns depth info.
      desc 'depth', 'Returns depth info of symbol specified by level'
      option :symbol, type: :string, required: true, desc: 'Transaction pairs'
      option :level,  type: :string, required: true, desc: 'Level of depth chart. level must be included in [L20, L40, full]'
      def depth
        symbol = options[:symbol]
        level  = options[:level]
        STDOUT.puts client.market_depth(symbol: symbol, level: level)
      end

      # Returns trades info of symbol.
      #
      # curl: GET https://api.fcoin.com/v2/market/trades/$symbol
      #
      # @example get ethusdt trades info.
      #  ./exe/fcoin market trades --symbol ethusdt
      #
      #
      # @see https://developer.fcoin.com/zh.html#6477a1394e
      # @raise [ArgumentError] If the symbol does not have.
      # @param symbol [String] Transaction pairs.
      # @return [JSON] Returns trades info.
      desc 'trades', 'Returns trades info of symbol'
      option :symbol, type: :string, required: true, desc: 'Transaction pairs'
      def trades
        symbol = options[:symbol]
        STDOUT.puts client.market_trades(symbol: symbol)
      end

      # Returns candles info of symbol specified by resolution.
      #
      # curl: GET https://api.fcoin.com/v2/market/candles/$resolution/$symbol
      #
      # @example get monthly(MN) ethusdt candles info.
      #  ./exe/fcoin market candles --symbol ethusdt --resolution D1
      #
      #
      # @see https://developer.fcoin.com/zh.html#candle
      # @raise [ArgumentError] If the symbol or resolution does not have.
      # @raise [InvalidValueError] If symbol or resolution is invalid.
      # @param symbol [String or Symbol] Transaction pairs.
      # @param resolution [String or Symbol] period of candles chart. resolution must be included in [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN].
      # @return [JSON] Returns candles info.
      desc 'candles', 'Returns candles info of symbol specified by resolution'
      option :symbol,     type: :string, required: true, desc: 'Transaction pairs'
      option :resolution, type: :string, required: true, desc: 'period of candles chart. resolution must be included in [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN]'
      def candles
        symbol = options[:symbol]
        resolution = options[:resolution]
        STDOUT.puts client.market_candles(symbol: symbol, resolution: resolution)
      end

      private

      def client
        @client = Fcoin::Client.new
      end
    end
  end
end

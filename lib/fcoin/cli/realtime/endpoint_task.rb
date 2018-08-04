require_relative '../../../fcoin'
require 'thor'

module Fcoin
  module RealTime
    class EndPointTask < Thor
      # Subscribe to ticker information
      #
      # @example Subscribe to ticker information of ethusdt
      #  ./bin/fcoin subscribe ticker --symbol ethusdt
      #
      #
      # @see https://developer.fcoin.com/zh.html#ticker
      # @raise [ArgumentError] If the symbol does not have.
      # @param symbol [String] Transaction pair.
      # @yieldreturn Process block arguments
      desc 'ticker', 'Subscribe to ticker information'
      option :symbol, type: :string, required: true, desc: 'Transaction pair'
      def ticker
        # @see bin/fcoin
      end

      # Subscribe to depth information
      #
      # @example Subscribe to depth information of ethusdt specified by L20 level
      #  ./bin/fcoin subscribe depth --symbol ethusdt --level L20
      #
      #
      # @see https://developer.fcoin.com/zh.html#50f4407ea4
      # @raise [ArgumentError] If the symbol or level does not have.
      # @raise [InvalidValueError] If symbol or level is invalid.
      # @param symbol [String] Transaction pair.
      # @param level [String] Level of depth chart. level must be included in [L20, L40, full].
      # @yieldreturn Process block arguments.
      desc 'depth', 'Subscribe to depth information'
      option :symbol, type: :string, required: true, desc: 'Transaction pair'
      option :level,  type: :string, required: true, desc: 'Level of depth chart. level must be included in [L20, L40, full]'
      def depth
        # @see bin/fcoin
      end

      # Subscribe to trade information
      #
      # @example Subscribe to trade information of ethusdt limit 5
      #  ./bin/fcoin subscribe trade --symbol ethusdt --limit 5
      #
      #
      # @see https://developer.fcoin.com/zh.html#6477a1394e
      # @raise [ArgumentError] If the symbol or level does not have.
      # @raise [InvalidValueError] If symbol or level is invalid.
      # @param symbol [String] Transaction pair.
      # @param limit [Integer]
      # @yieldreturn Process block arguments
      desc 'trade', 'Subscribe to trade information'
      option :symbol, type: :string, required: true, desc: 'Transaction pair'
      option :limit,  type: :numeric, default: 20
      def trade
        # @see bin/fcoin
      end

      # Subscribe to candle information
      #
      # @example Subscribe to candle information of ethusdt limit 5
      #  ./bin/fcoin subscribe candle --symbol ethusdt --resolution MN --limit 5
      #
      #
      # @see https://developer.fcoin.com/zh.html#candle
      # @raise [ArgumentError] If the symbol or resolution does not have.
      # @raise [InvalidValueError] If symbol or resolution is invalid.
      # @param symbol [String] Transaction pair.
      # @param resolution [String] period of candles chart. resolution must be included in [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN].
      # @param limit [Integer]
      # @yieldreturn Process block arguments
      desc 'candle', 'Subscribe to candle information'
      option :symbol,     type: :string, required: true, desc: 'Transaction pair'
      option :resolution, type: :string, required: true, desc: 'period of candles chart. resolution must be included in [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN]'
      option :limit,      type: :numeric, default: 20
      def candle
        # @see bin/fcoin
      end

      # Subscribe to topics
      #
      # @example Subscribe to topics
      #  ./bin/fcoin subscribe topics
      #
      #
      # @yieldreturn Process block arguments
      desc 'topics', 'Subscribe to topics'
      def topics
        # @see bin/fcoin
      end

      # Subscribe to server time
      #
      # @example Subscribe to Subscribe to server time
      #  ./bin/fcoin subscribe hello
      #
      #
      # @yieldreturn Process block arguments
      desc 'hello', 'Subscribe to server time'
      def hello
        # @see bin/fcoin
      end
    end
  end
end

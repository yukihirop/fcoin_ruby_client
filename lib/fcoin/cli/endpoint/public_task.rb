require_relative '../../../fcoin'
require 'thor'

module Fcoin
  module EndPoint
    class PublicTask < Thor
      # Get server time
      #
      # curl: GET https://api.fcoin.com/v2/public/server-time
      #
      # @example get server time
      #  ./exe/fcoin public server_time #=> {"status":0,"data":1531562028166}
      #
      #
      # @see https://developer.fcoin.com/zh.html#8aa898cda7
      # @return [JSON]
      desc 'server_time', 'Get server time'
      def server_time
        STDOUT.puts client.public_server_time
      end

      # Display available currency
      #
      # curl: GET https://api.fcoin.com/v2/public/currencies
      #
      # @example Display available currency
      #  ./exe/fcoin public currencies
      #
      #
      # @see https://developer.fcoin.com/zh.html#0fd2e492e6
      # @return [JSON]
      desc 'currencies', 'Display available currency'
      def currencies
        STDOUT.puts client.public_currencies
      end

      # Query available transaction pairs
      #
      # curl: GET https://api.fcoin.com/v2/public/symbols
      #
      # @example Query available transaction pairs
      #  ./exe/fcoin public symbols
      #
      #
      # @see https://developer.fcoin.com/zh.html#a266e284f4
      # @return [JSON]
      desc 'symbols', 'Query available transaction pairs'
      def symbols
        STDOUT.puts client.public_symbols
      end

      private

      def client
        @client = Fcoin::Client.new
      end
    end
  end
end

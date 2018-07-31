# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Public
      # Get server time
      #
      # curl: GET https://api.fcoin.com/v2/public/server-time
      #
      # @example get server time
      #  client = Fcoin::Client.new
      #  puts client.public_server_time #=> {"status":0,"data":1531562028166}
      #
      #
      # @see https://developer.fcoin.com/zh.html#8aa898cda7
      # @return [Hash]
      def public_server_time
        get('public/server-time', false)
      end

      # Display available currency
      #
      # curl: GET https://api.fcoin.com/v2/public/currencies
      #
      # @example Display available currency
      #  client = Fcoin::Client.new
      #  puts cient.public_currencies
      #
      #
      # @see https://developer.fcoin.com/zh.html#0fd2e492e6
      # @return [Hash]
      def public_currencies
        get('public/currencies', false)
      end

      # Query available transaction pairs
      #
      # curl: GET https://api.fcoin.com/v2/public/symbols
      #
      # @example Query available transaction pairs
      #  client = Fcoin::Client.new
      #  puts client.public_symbols
      #
      #
      # @see https://developer.fcoin.com/zh.html#a266e284f4
      # @return [Hash]
      def public_symbols
        get('public/symbols', false)
      end
    end
  end
end
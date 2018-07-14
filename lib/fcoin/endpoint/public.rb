# @see https://developer.fcoin.com/jp.html?javascript#32c808cbe5
# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Public
      # GET https://api.fcoin.com/v2/public/server-time
      def public_server_time
        get('public/server-time')
      end

      # GET https://api.fcoin.com/v2/public/currencies
      def public_currencies
        get('public/currencies')
      end

      # GET https://api.fcoin.com/v2/public/symbols
      def public_symbols
        get('public/symbols')
      end
    end
  end
end
require_relative '../../../fcoin'
require 'thor'

module Fcoin
  module EndPoint
    class AccountsTask < Thor
      # Get account info.
      #
      # curl: GET https://api.fcoin.com/v2/accounts/balance
      #
      # @note This method can not be invoked without authentication.
      #
      # @example get account info
      #  export FCOIN_API_KEY='your_fcoin_api_key'
      #  export FCOIN_SECRET_KEY='your_fcoin_secret_key'
      #  ./exe/fcoin accounts balance
      #
      #
      # @see https://developer.fcoin.com/zh.html#486f6037ed
      # @return [JSON]
      desc 'balance', 'Get account info'
      def balance
        STDOUT.puts client.accounts_balance
      end

      private

      def client
        Fcoin::Client.new
      end
    end
  end
end

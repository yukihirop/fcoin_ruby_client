# @see https://developer.fcoin.com/jp.html?javascript#32c808cbe5
# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Accounts
      # GET https://api.fcoin.com/v2/accounts/balance
      def accounts_balance
        get('accounts/balance')
      end
    end
  end
end

require_relative 'endpoint/public'
require_relative 'endpoint/market'
require_relative 'endpoint/accounts'

module Fcoin
  module Endpoint
    include Public
    include Market
    include Accounts
  end
end

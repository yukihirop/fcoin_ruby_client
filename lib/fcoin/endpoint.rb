require_relative 'endpoint/public'
require_relative 'endpoint/market'
require_relative 'endpoint/accounts'
require_relative 'endpoint/orders'

module Fcoin
  module Endpoint
    include Public
    include Market
    include Accounts
    include Orders
  end
end

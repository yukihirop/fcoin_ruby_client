require_relative 'endpoint/public'
require_relative 'endpoint/market'

module Fcoin
  module Endpoint
    include Public
    include Market
  end
end

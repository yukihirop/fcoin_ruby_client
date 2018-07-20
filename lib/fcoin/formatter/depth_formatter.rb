require_relative 'base_formatter'

module Fcoin
  class DepthFormatter < BaseFormatter

    attr_accessor :body

    def initialize(body)
      self.body = body
    end

    def formatted_body
      self.body['data']['bids'] = adjusted('bids')
      self.body['data']['asks'] = adjusted('asks')
      body
    end

    private

    def adjusted(type)
      orders = body['data'][type].dup
      orders.in_groups_of(2).map do |order|
        {
          "price" => order[0],
          "amount" => order[1]
        }
      end
    end
  end
end

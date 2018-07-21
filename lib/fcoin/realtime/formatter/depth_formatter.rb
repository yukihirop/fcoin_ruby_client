require_relative 'base_formatter'
require 'active_support'
require 'active_support/core_ext'

module Fcoin
  module RealTime
    class DepthFormatter < BaseFormatter

      attr_accessor :data

      def initialize(data)
        self.data = data
      end

      def formatted_data
        self.data['bids'] = adjusted('bids')
        self.data['asks'] = adjusted('asks')
        data
      end

      private

      def adjusted(type)
        orders = data[type].dup
        orders.in_groups_of(2).map do |order|
          {
            "price" => order[0],
            "amount" => order[1]
          }
        end
      end
    end
  end
end

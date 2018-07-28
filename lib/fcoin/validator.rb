require_relative 'validator/market'
require_relative 'validator/orders'

# Scope Fcoin::API
module Fcoin
  class Validator
    def self.build(params)
      case params[:method_name]
      when /market_depth/
        MarketValidator.new(params.slice(:level, :method_name))
      when /market_candles/
        MarketValidator.new(params.slice(:resolution, :method_name))
      when /create_order/
        OrdersValidator.new(params.slice(:symbol, :side, :type, :price, :amount, :method_name))
      when /order_list/
        OrdersValidator.new(params.slice(:symbol, :states, :method_name))
      else
        new params
      end
    end

    def valid?
      true
    end

    def messages
      {}
    end

    private

    def initialize(params)
      self.level       = params[:level]
      self.resolution  = params[:resolution]
      self.symbol      = params[:symbol]
      self.side        = params[:side]
      self.type        = params[:type]
      self.price       = params[:price]
      self.amount      = params[:amount]
      self.states      = params[:states]
      self.method_name = params[:method_name]
    end

    attr_accessor :level, :resolution, :symbol, :side, :type, :price, :amount, :states, :method_name
  end
end

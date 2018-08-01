require_relative 'validator/market_validator'
require_relative 'validator/orders_validator'

# Scope Fcoin::API
module Fcoin
  class Validator
    # Build a validator model depending on the method_name
    #
    # @param params [Hash] Parameter you want to verify including the called method name
    # @option params :level [String or Symbol] Level of depth chart
    # @option params :resolution [String or Symbol] period of Candles Chart
    # @option params :symbol [String or Symbol] Transaction pair
    # @option params :side [String or Symbol] Direction of the transaction
    # @option params :type [String or Symbol] Order type
    # @option params :price [Float]
    # @option params :amount [Float]
    # @option params :states [String] Order state
    # @option params :method_name [String or Symbol] invoked method name
    def self.build(params)
      case params[:method_name]
      when /market_depth|on_depth/
        MarketValidator.new(params.slice(:level, :method_name))
      when /market_candles|on_candle/
        MarketValidator.new(params.slice(:resolution, :method_name))
      when /create_order/
        OrdersValidator.new(params.slice(:symbol, :side, :type, :price, :amount, :method_name))
      when /order_list/
        OrdersValidator.new(params.slice(:symbol, :states, :method_name))
      else
        new params
      end
    end

    # Whether the parameters are valid?
    def valid?
      true
    end

    # Error message when invalid
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

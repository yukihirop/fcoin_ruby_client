require_relative 'validator/market_validator'
require_relative 'validator/orders_validator'

# Scope Fcoin::API
module Fcoin
  class Validator
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

    # Whether the parameters are valid?
    def valid?
      validator.present? ? validator.valid? : true
    end

    # Error message when invalid
    def messages
      validator.present? ? validator.messages : {}
    end

    private

    def validator
      case method_name
      when /market_depth|on_depth/
        MarketValidator.new(level: level, method_name: method_name)
      when /market_candles|on_candle/
        MarketValidator.new(resolution: resolution, method_name: method_name)
      when /create_order/
        OrdersValidator.new(symbol: symbol, side: side, type: type, price: price, amount: amount, method_name: method_name)
      when /order_list/
        OrdersValidator.new(symbol: symbol, states: states, method_name: method_name)
      else
        nil
      end
    end

    attr_accessor :level, :resolution, :symbol, :side, :type, :price, :amount, :states, :method_name
  end
end

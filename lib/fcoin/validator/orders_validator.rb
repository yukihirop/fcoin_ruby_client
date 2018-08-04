require_relative 'orders/create_order_limit_validator'
require_relative 'orders/create_order_market_validator'
require_relative 'orders/order_list_validator'

module Fcoin
  class OrdersValidator

    # @param params [Hash] Parameter you want to verify including the called method name
    # @option params :symbol [String or Symbol] Transaction pair
    # @option params :side [String or Symbol] Direction of the transaction
    # @option params :type [String or Symbol] Order type
    # @option params :price [Float]
    # @option params :amount [Float]
    # @option params :states [String] Order state
    # @option params :method_name [String or Symbol] invoked method name
    def initialize(params)
      self.symbol      = params[:symbol]
      self.side        = params[:side]
      self.type        = params[:type]
      self.price       = params[:price]
      self.amount      = params[:amount]
      self.total       = params[:total]
      self.states      = params[:states]
      self.method_name = params[:method_name]
    end

    # Validate according to method_name
    def valid?
      validator.present? ? validator.valid? : false
    end

    # Error message when invalid
    def messages
      return {} if valid?
      results = []
      results << (validator.present? ? validator.messages : {})
      results.compact&.each_with_object({}) { |message, data| data.merge!(message) }
    end

    private

    attr_accessor :symbol, :side, :type, :price, :total, :amount, :states, :method_name

    def validator
      case method_name.to_sym
      when :create_order_limit
        create_order_limit_validator
      when :create_order_market
        create_order_market_validator
      when :order_list
        order_list_validator
      else
        nil
      end
    end

    def create_order_limit_validator
      @create_order_limit_validator ||= Orders::CreateOrderLimitValidator.new(symbol: symbol, side: side, price: price, amount: amount)
    end

    def create_order_market_validator
      @create_order_market_validator ||= Orders::CreateOrderMarketValidator.new(symbol: symbol, side: side, total: total, amount: amount)
    end

    def order_list_validator
      @order_list_validator ||= Orders::OrderListValidator.new(symbol: symbol, states: states)
    end
  end
end

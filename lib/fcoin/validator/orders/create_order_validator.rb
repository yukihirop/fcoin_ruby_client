require_relative 'create_order_limit_validator'
require_relative 'create_order_market_validator'
require_relative 'base_validator'
require_relative '../validator_utility'

module Fcoin
  module Orders
    class CreateOrderValidator < BaseValidator
      include ValidatorUtility

      # @param params [Hash] Parameter you want to verify including the called method name
      # @option params :symbol [String or Symbol] Transaction pair
      # @option params :side [String or Symbol] Direction of the transaction
      # @option params :type [String or Symbol] Order type
      # @option params :price [Float]
      # @option params :amount [Float]
      def initialize(params)
        self.symbol      = params[:symbol]
        self.side        = params[:side]
        self.type        = params[:type]
        self.price       = params[:price]
        self.amount      = params[:amount]
      end

      # Validate according to method_name
      def valid?
        return false unless valid_type?
        validator.present? ? validator.valid? : false
      end

      # Error message when invalid
      def messages
        return {} if valid?
        results = []
        results << includes_error_message(type, :type, valid_types) unless valid_type?
        results << (validator.present? ? validator.messages : {})
        results.compact&.each_with_object({}) { |message, data| data.merge!(message) }
      end

      private

      def validator
        case type.to_sym
        when :limit
          create_order_limit_validator
        when :market
          create_order_market_validator
        else
          nil
        end
      end

      def create_order_limit_validator
        @create_order_limit_validator ||= CreateOrderLimitValidator.new(symbol: symbol, side: side, price: price, amount: amount)
      end

      def create_order_market_validator
        @create_order_market_validator ||= CreateOrderMarketValidator.new(symbol: symbol, side: side, amount: amount)
      end
    end
  end
end

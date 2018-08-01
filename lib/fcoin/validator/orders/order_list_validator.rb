require_relative 'base_validator'
require_relative '../utility'

module Fcoin
  module Orders
    class OrderListValidator < BaseValidator
      include ValidatorUtility

      # @param params [Hash] Parameter you want to verify including the called method name
      # @option params :symbol [String or Symbol] Transaction pair
      # @option params :states [String] Order state
      def initialize(params)
        self.symbol      = params[:symbol]
        self.states      = params[:states]
      end

      # Validate according to method_name
      def valid?
        valid_symbol? && valid_states?
      end

      # Error message when invalid
      def messages
        return {} if valid?
        results = []

        results << presence_error_message(symbol, :symbol) unless valid_symbol?
        results << includes_error_message(states, :states, valid_states) unless valid_states?
        results.compact&.each_with_object({}) { |message, data| data.merge!(message) }
      end
    end
  end
end

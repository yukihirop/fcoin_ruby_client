require_relative 'base_validator'
require_relative '../utility'
require 'pry'

module Fcoin
  module Orders
    class CreateOrderLimitValidator < BaseValidator
      include ValidatorUtility

      # @param params [Hash] Parameter you want to verify including the called method name
      # @option params :symbol [String or Symbol] Transaction pair
      # @option params :side [String or Symbol] Direction of the transaction
      # @option params :price [Float]
      # @option params :amount [Float]
      def initialize(params)
        self.symbol      = params[:symbol]
        self.side        = params[:side]
        self.price       = params[:price]
        self.amount      = params[:amount]
      end

      # Validate according to method_name
      def valid?
        if valid_symbol_setting_exist?
          valid_price? && valid_amount?
        else
          valid_symbol? && valid_side?
        end
      end

      # Error message when invalid
      def messages
        return {} if valid?
        results = []

        results << presence_error_message(symbol, :symbol) unless valid_symbol?
        results << includes_error_message(side, :side, valid_sides) unless valid_side?
        if valid_symbol_setting_exist?
          results << between_error_message(price,  :price,  min(:price),  max(:price)) unless valid_price?
          results << between_error_message(amount, :amount, min(:amount), max(:amount)) unless valid_amount?
        end
        results.compact&.each_with_object({}) { |message, data| data.merge!(message) }
      end

      private

      def valid_symbols
        return HashWithIndifferentAccess.new unless valid_side?
        ::Settings.fcoin.validation.limit[side].to_h.values.flatten.compact.each_with_object(HashWithIndifferentAccess.new) do |setting, data|
          data[setting.symbol] = setting
        end
      end
    end
  end
end

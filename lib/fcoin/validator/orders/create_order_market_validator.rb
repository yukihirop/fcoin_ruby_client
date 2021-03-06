require_relative 'base_validator'
require_relative '../validator_utility'

module Fcoin
  module Orders
    class CreateOrderMarketValidator < BaseValidator
      include ValidatorUtility

      # @param params [Hash] Parameter you want to verify including the called method name
      # @option params :symbol [String or Symbol] Transaction pair
      # @option params :side [String or Symbol] Direction of the transaction
      # @option params :total [Float]
      # @option params :amount [Float]
      def initialize(params)
        self.symbol      = params[:symbol]
        self.side        = params[:side]
        self.total       = params[:amount] # this is not a mistake
        self.amount      = params[:amount]
      end

      # Validate according to method_name
      def valid?
        case
        when valid_symbol_setting_exist?
          case
          when sell?
            valid_amount?
          when buy?
            valid_total?
          end
        when invalid_symbol_setting_exist?
          false
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

        case
        when valid_symbol_setting_exist?
          case
          when sell?
            results << between_error_message(amount, :amount, min(:amount), max(:amount)) unless valid_amount?
          when buy?
            results << between_error_message(total, :total, min(:total), max(:total)) unless valid_total?
          end
        when invalid_symbol_setting_exist?
          results << invalid_create_order_market_error_message(symbol, :symbol)
        end
        results.compact&.each_with_object({}) { |message, data| data.merge!(message) }
      end

      private

      def sell?
        side.to_s == 'sell'
      end

      def buy?
        side.to_s == 'buy'
      end

      def invalid_create_order_market_error_message(value, type)
        message = {}
        adjusted_value = value.present? ? value : 'nil'
        message[type] = "#{type} is #{adjusted_value}. This #{type} board is not adapted on-going order."
        message
      end

      def invalid_symbol_setting_exist?
        invalid_symbols[symbol].present?
      end

      def valid_symbols
        return HashWithIndifferentAccess.new unless valid_side?
        ::Settings.fcoin.validation.market.valid[side].to_h.values.flatten.compact.each_with_object(HashWithIndifferentAccess.new) do |setting, data|
          data[setting.symbol] = setting
        end
      end

      def invalid_symbols
        return HashWithIndifferentAccess.new unless valid_side?
        ::Settings.fcoin.validation.market.invalid[side].to_h.values.flatten.compact.each_with_object(HashWithIndifferentAccess.new) do |setting, data|
          data[setting] = setting
        end
      end
    end
  end
end

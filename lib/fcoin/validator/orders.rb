require_relative 'utility'

module Fcoin
  class OrdersValidator
    include ValidatorUtility

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
      self.states      = params[:states]
      self.method_name = params[:method_name]
    end

    # Validate according to method_name
    def valid?
      if symbol_setting_exist?
        case method_name
        when /create_order/
          valid_symbol? && valid_side? && valid_type? && valid_price? && valid_amount?
        when /order_list/
          valid_symbol? && valid_states?
        end
      else
        valid_symbol?
      end
    end

    # Error message when invalid
    def messages
      return {} if valid?
      results = []

      results << presence_error_message(symbol, :symbol) unless valid_symbol?
      case method_name
      when /create_order/
        results << includes_error_message(side, :side, valid_sides) unless valid_side?
        results << includes_error_message(type, :type, valid_types) unless valid_type?
        if symbol_setting_exist?
          results << between_error_message(price,  :price,  min(:price),  max(:price)) unless valid_price?
          results << between_error_message(amount, :amount, min(:amount), max(:amount)) unless valid_amount?
        end
      when /order_list/
        results << includes_error_message(states, :states, valid_states) unless valid_states?
      end
      results.compact&.each_with_object({}) { |message, data| data.merge!(message) }
    end

    private

    attr_accessor :symbol, :side, :type, :price, :amount, :states, :method_name

    def valid_symbol?
      symbol.present?
    end

    def valid_side?
      side.to_s.in? valid_sides
    end

    def valid_type?
      type.to_s.in? valid_types
    end

    def valid_price?
      price.present? && price.between?(min(:price), max(:price))
    end

    def valid_amount?
      amount.present? && amount.between?(min(:amount), max(:amount))
    end

    def valid_states?
      states_arr = states.to_s&.split(',')
      states_arr.present? && states_arr.map { |state| state.in? valid_states }.all?
    end

    def min(type)
      symbol_setting_exist? ? symbols[symbol][type].to_h[:min] : 0
    end

    def max(type)
      symbol_setting_exist? ? symbols[symbol][type].to_h[:max] : 0
    end

    def symbol_setting_exist?
      symbols[symbol].present?
    end

    def valid_sides
      ::Settings.fcoin.validation.params.side
    end

    def valid_types
      ::Settings.fcoin.validation.params.type
    end

    def valid_states
      ::Settings.fcoin.validation.params.states
    end

    def symbols
      ::Settings.fcoin.validation.limit.to_h.values.flatten.compact.each_with_object(HashWithIndifferentAccess.new) do |setting, data|
        data[setting.symbol] = setting
      end
    end
  end
end

module Fcoin
  module Orders
    class BaseValidator

      # @param params [Hash] Parameter you want to verify including the called method name
      # @option params :symbol [String or Symbol] Transaction pair
      # @option params :side [String or Symbol] Direction of the transaction
      # @option params :price [Float]
      # @option params :total [Float]
      # @option params :amount [Float]
      # @option params :states [String] Order state
      def initialize(params)
        self.symbol      = params[:symbol]
        self.side        = params[:side]
        self.price       = params[:price]
        self.total       = params[:total]
        self.amount      = params[:amount]
        self.states      = params[:states]
      end

      # Validate according to method_name
      # @abstract Subclass and override {#valid?} to implement
      def valid?
        raise 'Please be implemented in inheriting.'
      end

      # Error message when invalid
      # @abstract Subclass and override {#messages} to implement
      def messages
        raise 'Please be implemented in inheriting.'
      end

      private

      attr_accessor :symbol, :side, :type, :price, :total, :amount, :states

      def valid_symbol?
        symbol.present?
      end

      def valid_side?
        side.to_s.in? valid_sides
      end

      def valid_type?
        type.to_s.in? valid_types
      end

      def valid_states?
        states_arr = states.to_s.gsub(' ','')&.split(',')
        states_arr.present? && states_arr.map { |state| state.in? valid_states }.all?
      end

      def valid_price?
        price.present? && price.between?(min(:price), max(:price))
      end

      def valid_total?
        total.present? && total.between?(min(:total), max(:total))
      end

      def valid_amount?
        amount.present? && amount.between?(min(:amount), max(:amount))
      end

      def min(type)
        valid_symbol_setting_exist? ? valid_symbols[symbol][type].to_h[:min] : 0
      end

      def max(type)
        valid_symbol_setting_exist? ? valid_symbols[symbol][type].to_h[:max] : 0
      end

      def valid_symbol_setting_exist?
        valid_symbols[symbol].present?
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

      # @abstract Subclass and override {#valid_symbols} to implement
      def valid_symbols
        raise 'Please be implemented in inheriting.'
      end
    end
  end
end

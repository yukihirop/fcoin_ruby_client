module Fcoin
  module Validation
    module Orders
      def create_order_params
        # http://dry-rb.org/gems/dry-validation/custom-validation-blocks/
        Dry::Validation.Params do
          configure do
            option :symbol

            def valid_price?(symbol, price)
              min = symbols[symbol].price.to_h[:min]
              max = symbols[symbol].price.to_h[:max]
              price.between?(min, max)
            end

            def valid_amount?(symbol, amount)
              min = symbols[symbol].amount.to_h[:min]
              max = symbols[symbol].amount.to_h[:max]
              amount.between?(min, max)
            end

            def valid_side?(side)
              side.in? ::Settings.fcoin.validation.query.side
            end

            def valid_type?(type)
              type.in? ::Settings.fcoin.validation.query.type
            end

            def symbols
              ::Settings.fcoin.validation.limit.to_h.values.flatten.compact.each_with_object(HashWithIndifferentAccess.new) do |setting, data|
                data[setting.symbol] = setting
              end
            end

            def self.messages
              super.merge(
                en: { errors: { create_order_price:  "price is not valid" } },
                en: { errors: { create_order_amount: "amount is not valid" } },
                en: { errors: { create_order_side: "side is not valid" } },
                en: { errors: { create_order_type: "type is not valid" } }
              )
            end
          end

          required(:price).maybe(:int?)
          required(:amount).maybe(:int?)
          required(:symbol).maybe(:str?)
          required(:side).maybe(:str?)
          required(:type).maybe(:str?)

          validate(create_order_price: [:price]) do |price|
            valid_price?(symbol, price)
          end

          validate(create_order_amount: [:amount]) do |amount|
            valid_amount?(symbol, amount)
          end

          validate(craete_order_side: [:side]) do |side|
            valid_side?(side)
          end

          validate(create_order_type: [:type]) do |type|
            valid_type?(type)
          end
        end
      end

      def order_list_schema
        Dry::Validation.Schema do
          configure do
            def valid_states
              ::Settings.fcoin.validation.query.states
            end
          end

          required(:states).maybe(:str?)
          required(:states).filled(included_in?: valid_states)
        end
      end
    end
  end
end
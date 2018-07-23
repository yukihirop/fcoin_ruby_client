require 'dry-validation'
require_relative 'validation/market'
require_relative 'validation/orders'

# Scope Fcoin::API
module Fcoin
  module Validation
    include Market
    include Orders

    def validation(method, params)
      adjusted_params = params.transform_values { |v| v.is_a?(Symbol) ? v.to_s : v }
      binding.pry
      schema(method, params).call(adjusted_params)
    end

    def schema(method, params)
      case method
      when /create_order/
        create_order_params.with(params.slice(:symbol))
      else
        send("#{method}_schema")
      end
    end
  end
end

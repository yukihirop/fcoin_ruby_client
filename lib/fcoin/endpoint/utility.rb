# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Utility
      private
      
      def required_missing_error(required, *required_keys)
        missing_keys = []
        required_keys.each do |key|
           missing_keys << key.to_sym if required[key].nil?
        end
        unless missing_keys.blank?
          error_message = "Required arguments: #{missing_keys.join(', ')} is missing"
          raise ArgumentError.new(error_message)
        end
      end

      def sort_payload(data)
        # sort by alphabel ASC
        Hash[ data.sort ]
      end
      alias :sort_params :sort_payload
    end
  end
end

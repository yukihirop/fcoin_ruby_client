# Scope Fcoin::API
module Fcoin
  module Endpoint
    module Utility
      private

      def sort_payload(data)
        # sort by alphabel ASC
        Hash[ data.sort ]
      end
      alias :sort_params :sort_payload
    end
  end
end

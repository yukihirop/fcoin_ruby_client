module Fcoin
  module RealTime
    class BaseFormatter
      # @abstract Subclass and override {#fromatted_data} to implement
      def formatted_data
        raise 'Please be implemented in inheriting.'
      end
    end
  end
end

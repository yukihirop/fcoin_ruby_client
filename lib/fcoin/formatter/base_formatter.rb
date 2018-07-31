module Fcoin
  class BaseFormatter
    # @abstract Subclass and override {#fromatted_body} to implement
    def formatted_body
      raise 'Please be implemented in inheriting.'
    end
  end
end

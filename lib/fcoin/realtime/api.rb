require_relative 'endpoint'

module Fcoin
  module RealTime
    class API
      include EndPoint

      attr_accessor :callbacks, :topics

      def initialize(options={})
        options = Fcoin.options.merge(options)
        self.wss_endpoint = options[:wss_endpoint]
        self.callbacks    = {}
        self.topics       = []
      end

      private

      attr_accessor :wss_endpoint
    end
  end
end
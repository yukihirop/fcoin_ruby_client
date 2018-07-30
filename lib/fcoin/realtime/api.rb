require_relative 'endpoint'
require_relative '../validator'

module Fcoin
  module RealTime
    class API
      include EndPoint

      attr_accessor :callbacks, :topics

      # @param [Hash] options the options to setting Fcoin Setting. For example, Validation and so on.
      # @option options [String] :adapter(Faraday.default_adapter)
      # @option options [String] :endpoint(https://api.fcoin.com/v2/) REST API endpoint
      # @option options [String] :wss_endpoint(wss://api.fcoin.com/v2/ws) Websocket endpoint
      # @option options [String] :user_agent
      # @option options [String] :proxy(nil)
      # @option options [String] :ca_path
      # @option options [String] :ca_file
      # @option options [Array<Faraday::Middleware>] :middlewares request faraday middlewares
      # @option options [String] :api_key
      # @option options [String] :secret_key
      # @option options [Boolean] :skip_validation(true)
      # @option options [String] :validation_setting_path  configuration file path for validation
      def initialize(options={})
        merged_options = Fcoin.options.merge(options)
        Configuration::VALID_OPTIONS_KEYS.each do |key|
          send("#{key}=", merged_options[key])
        end
        self.callbacks    = {}
        self.topics       = []
      end

      private

      attr_accessor :wss_endpoint, *Configuration::VALID_OPTIONS_KEYS
    end
  end
end

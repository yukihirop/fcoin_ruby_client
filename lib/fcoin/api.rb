require_relative 'connection'
require_relative 'request'
require_relative 'endpoint'
require_relative 'error'
require_relative 'realtime/api'
require 'active_support'
require 'active_support/core_ext'

module Fcoin
  class API
    include Connection
    include Request
    include Endpoint

    # @param [Hash] options the options to setting Fcoin Setting. For example, Authorization, Validation and so on.
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
      self.merged_options = Fcoin.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    # Build realtime client
    #
    # @see RealTime::Client
    # @return [Fcoin::RealTime::Client]
    def realtime
      RealTime::Client.new(merged_options)
    end

    private

    attr_accessor *Configuration::VALID_OPTIONS_KEYS, :merged_options
  end
end

# frozen_string_literal:true
require 'faraday'
require 'config'

module Fcoin
  module Configuration

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP
    DEFAULT_ADAPTER                 = ::Faraday.default_adapter

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT                = 'https://api.fcoin.com/v2/'
    DEFAULT_WSS_ENDPOINT            = 'wss://api.fcoin.com/v2/ws'
    
    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT              = "Fcoin Ruby Gem #{Fcoin::VERSION}".freeze
    DEFAULT_PROXY                   = nil
    DEFAULT_CA_PATH                 = %x[ openssl version -a | grep OPENSSLDIR | awk '{print $2}'|sed -e 's/\"//g' ].chomp
    DEFAULT_CA_FILE                 = "#{DEFAULT_CA_PATH}/ca-certificates.crt"
    DEFAULT_MIDDLEWARES             = []
    DEFAULT_API_KEY                 = 'Fcoin API Public Key'
    DEFAULT_SECRET_KEY              = 'Fcoin API Secret Key'
    DEFAULT_SKIP_VALIDATION         = true
    DEFAULT_VALIDATION_SETTING_PATH = File.expand_path('../config/custom_settings.yml',__FILE__)

    # An array of valid keys in the options hash when configuring a Fcoin::API
    VALID_OPTIONS_KEYS = [
      :adapter,
      :endpoint,
      :wss_endpoint,
      :user_agent,
      :api_key,
      :secret_key,
      :proxy,
      :ca_path,
      :ca_file,
      :middlewares,
      :skip_validation,
      :validation_setting_path
    ].freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values and load validation setting path
    def self.extended(base)
      base.set_default
      base.load_validation_setting
    end

    # Convenience method to allow configuration options to be set in block
    def configure
      yield self
      load_validation_setting
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Load a configuration file to use in the gem that config
    def load_validation_setting
      Config.load_and_set_settings([
        File.expand_path('../config/settings.yml', __FILE__),
        validation_setting_path
      ])
    end

    # Set all configuration options to defaults
    def set_default
      self.adapter                 = DEFAULT_ADAPTER
      self.endpoint                = DEFAULT_ENDPOINT
      self.wss_endpoint            = DEFAULT_WSS_ENDPOINT
      self.user_agent              = DEFAULT_USER_AGENT
      self.api_key                 = DEFAULT_API_KEY
      self.secret_key              = DEFAULT_SECRET_KEY
      self.proxy                   = DEFAULT_PROXY
      self.ca_path                 = DEFAULT_CA_PATH
      self.ca_file                 = DEFAULT_CA_FILE
      self.middlewares             = DEFAULT_MIDDLEWARES
      self.skip_validation         = DEFAULT_SKIP_VALIDATION
      self.validation_setting_path = DEFAULT_VALIDATION_SETTING_PATH
    end
  end
end

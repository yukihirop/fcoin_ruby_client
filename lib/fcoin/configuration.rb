require 'faraday'

module Fcoin
  module Configuration

    DEFAULT_ADAPTER     = ::Faraday.default_adapter
    DEFAULT_ENDPOINT    = 'https://api.fcoin.com/v2/'
    DEFAULT_USER_AGENT  = "Fcoin Ruby Gem #{Fcoin::VERSION}".freeze
    DEFAULT_PROXY       = nil
    # /private/etc/ssl
    DEFAULT_CA_PATH     = %x[ openssl version -a | grep OPENSSLDIR | awk '{print $2}'|sed -e 's/\"//g' ].chomp
    DEFAULT_CA_FILE     = "#{DEFAULT_CA_PATH}/ca-certificates.crt"
    DEFAULT_MIDDLEWARES = []

    VALID_OPTIONS_KEYS = [
      :adapter,
      :endpoint,
      :user_agent,
      :proxy,
      :ca_path,
      :ca_file,
      :middlewares
    ].freeze

    def self.extended(base)
      base.set_default
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    def set_default
      self.adapter     = DEFAULT_ADAPTER
      self.endpoint    = DEFAULT_ENDPOINT
      self.user_agent  = DEFAULT_USER_AGENT
      self.proxy       = DEFAULT_PROXY
      self.ca_path     = DEFAULT_CA_PATH
      self.ca_file     = DEFAULT_CA_FILE
      self.middlewares = DEFAULT_MIDDLEWARES
    end

    private

    attr_accessor *VALID_OPTIONS_KEYS
  end
end

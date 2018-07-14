require 'faraday'
require 'pry'

module Fcoin
  module Configuration

    DEFAULT_ADAPTER  = ::Faraday.default_adapter
    DEFAULT_TOKEN    = nil
    DEFAULT_ENDPOINT = 'https://api.fcoin.com/v2'

    VALID_OPTIONS_KEYS = [
      :adapter,
      :token,
      :endpoint
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
      self.adapter  = DEFAULT_ADAPTER
      self.token    = DEFAULT_TOKEN
      self.endpoint = DEFAULT_ENDPOINT
    end

    private

    attr_accessor *VALID_OPTIONS_KEYS
  end
end

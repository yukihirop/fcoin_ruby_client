require_relative 'connection'
require_relative 'request'
require_relative 'endpoint'
require_relative 'error'
require 'active_support'
require 'active_support/core_ext'

module Fcoin
  class API
    include Connection
    include Request
    include Endpoint

    def initialize(options={})
      options = Fcoin.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    private

    attr_accessor *Configuration::VALID_OPTIONS_KEYS
  end
end

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

    def initialize(options={})
      self.merged_options = Fcoin.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def realtime
      RealTime::Client.new(merged_options)
    end

    private

    attr_accessor *Configuration::VALID_OPTIONS_KEYS, :merged_options
  end
end

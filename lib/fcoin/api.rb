require_relative 'connection'

module Fcoin
  class API
    include Connection

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

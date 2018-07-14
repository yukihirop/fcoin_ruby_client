module Fcoin
  class API
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

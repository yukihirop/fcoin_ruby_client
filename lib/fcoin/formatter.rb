require_relative 'formatter/ticker_formatter.rb'
require_relative 'formatter/depth_formatter.rb'

module Fcoin
  class Formatter
    def initialize(body)
      self.body = body
    end

    def self.build(body)
      if use_formatter?(body)
        case body['data']['type']
        when /ticker/
          TickerFormatter.new(body)
        when /depth/
          DepthFormatter.new(body)
        else
          new(body)
        end
      else
        new(body)
      end
    end

    def formatted_body
      body
    end

    private

    attr_accessor :body

    def self.use_formatter?(body)
      !(body['data'].nil? || !body['data'].is_a?(Hash) || body['data']['type'].nil?)
    end
  end
end

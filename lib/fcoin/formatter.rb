require_relative 'formatter/ticker_formatter.rb'
require_relative 'formatter/depth_formatter.rb'

module Fcoin
  class Formatter
    def initialize(body)
      self.body = body
    end

    # Format body
    def formatted_body
      formatter.present? ? formatter.formatted_body : body
    end

    private

    attr_accessor :body

    def formatter
      if use_formatter?(body)
        case body['data']['type']
        when /ticker/
          TickerFormatter.new(body)
        when /depth/
          DepthFormatter.new(body)
        else
          nil
        end
      else
        nil
      end
    end

    def use_formatter?(body)
      !(body['data'].nil? || !body['data'].is_a?(Hash) || body['data']['type'].nil?)
    end
  end
end

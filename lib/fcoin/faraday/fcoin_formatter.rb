require 'faraday'
require_relative '../formatter'

module FaradayMiddleware
  class FcoinFormatter < Faraday::Middleware
    # Format response_env by using Fcoin::Formatter
    def call(request_env)
      @app.call(request_env).on_complete do |response_env|
        body = JSON.parse(response_env.body)
        formatter = Fcoin::Formatter.new(body)
        response_env.body = formatter.formatted_body
      end
    end
  end

  Faraday::Response.register_middleware(fcoin_formatter: FcoinFormatter)
end

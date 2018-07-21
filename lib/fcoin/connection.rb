require 'faraday_middleware'
require_relative 'faraday/fcoin_formatter'

# Scope Fcoin::API
module Fcoin
  module Connection
    private

    def connection
      options = {
        :headers => { 'Accept' => 'application/json; charset=utf-8', 'User-Agent' => user_agent, 'Content-Type' => 'application/json' },
        :proxy => proxy,
        :url => endpoint,
        :ssl => { :ca_path => ca_path, :ca_file => ca_file }
      }

      Faraday::Connection.new(options) do |conn|
        Array(middlewares).each do |middleware|
          conn.request middleware
        end
        conn.request :multipart
        conn.request :url_encoded
        conn.request :json

        conn.response :fcoin_formatter
        conn.adapter(adapter)
      end
    end
  end
end

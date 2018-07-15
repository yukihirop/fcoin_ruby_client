require_relative 'authorization'

# Scope Fcoin::API
module Fcoin
  module Request
    def get(path, payload={})
      request(:get, path, payload)
    end

    def post(path, payload={})
      request(:post, path, payload)
    end

    def put(path, payload={})
      request(:put, path, payload)
    end

    def delete(path, payload={})
      request(:delete, path, payload)
    end

    private

    def request(http_method, path, payload)
      response = connection.send(http_method) do |request|
        required = {
          http_method: http_method,
          path:        path,
          payload:     payload,
          endpoint:    endpoint,
          api_key:     api_key,
          secret_key:  secret_key
        }
        
        auth = Fcoin::Authorization.new(required)
        request.headers.merge!(auth.original_headers)

        case http_method
        when :get, :delete
          request.url(path, payload)
        when :post, :put
          request.path = path
          request.body = payload unless payload.empty?
        end
      end
      return response
    end
  end
end

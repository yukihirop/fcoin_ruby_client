require_relative 'authorization'

# Scope Fcoin::API
module Fcoin
  module Request
    def get(path, auth=true, payload={})
      request(:get, path, auth, payload)
    end

    def post(path, auth=true, payload={})
      request(:post, path, auth, payload)
    end

    def put(path, auth=true, payload={})
      request(:put, path, auth, payload)
    end

    def delete(path, auth=true, payload={})
      request(:delete, path, auth, payload)
    end

    private

    def request(http_method, path, auth, payload)
      response = connection.send(http_method) do |request|
        required = {
          http_method: http_method,
          path:        path,
          payload:     payload,
          endpoint:    endpoint,
          api_key:     api_key,
          secret_key:  secret_key
        }
        
        if auth
          auth = Fcoin::Authorization.new(required)
          request.headers.merge!(auth.original_headers)
        end

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

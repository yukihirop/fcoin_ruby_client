require_relative 'authorization'
require_relative 'formatter'

# Scope Fcoin::API
module Fcoin
  module Request
    # Perform an HTTP GET request
    def get(path, auth=true, payload={})
      request(:get, path, auth, payload)
    end

    # Perform an HTTP POST request
    def post(path, auth=true, payload={})
      request(:post, path, auth, payload)
    end

    # Perform an HTTP PUT request
    def put(path, auth=true, payload={})
      request(:put, path, auth, payload)
    end

    # Perform an HTTP DELETE request
    def delete(path, auth=true, payload={})
      request(:delete, path, auth, payload)
    end

    private

    # Perform an HTTP request
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

      return formatted(response.body)
    end

    # change the output format of the body
    #
    # @param body [Hash]
    # @return [Hash or JSON]
    def formatted(body)
      case format_type
      when :json
        body.to_json
      when :hash
        body
      else
        raise "format_type is #{format_type}. format_type must be included in [:json, :hash]."
      end
    end
  end
end

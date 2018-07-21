require 'openssl'
require 'base64'
require 'active_support'
require 'active_support/core_ext'

module Fcoin
  class Authorization
    def initialize(required)
      self.http_method = required[:http_method]
      self.path        = required[:path]
      self.payload     = required[:payload]
      self.endpoint    = required[:endpoint]
      self.api_key     = required[:api_key]
      self.secret_key  = required[:secret_key]
    end

    def original_headers
      {
         'FC-ACCESS-KEY'       => api_key,
         'FC-ACCESS-SIGNATURE' => encoded_signature,
         'FC-ACCESS-TIMESTAMP' => timestamp
      }
    end

    private

    attr_accessor :http_method, :path, :payload, :endpoint, :api_key, :secret_key

    def encoded_signature
      base64_signature = Base64.strict_encode64(signature)
      Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', secret_key.to_s, base64_signature))
    end

    def signature
      # https://developer.fcoin.com/jp.html?javascript#32c808cbe5
      # HTTP_METHOD + HTTP_REQUEST_URI + TIMESTAMP + POST_BODY
      # e.x.) POSThttps://api.fcoin.com/v2/orders1523069544359amount=100.0&price=100.0&side=buy&symbol=btcusdt&type=limit
      if http_method == :get && query_string.present?
        http_method.upcase.to_s + full_url.to_s + '?' +query_string.to_s + timestamp.to_s
      else
        http_method.upcase.to_s + full_url.to_s + timestamp.to_s + query_string.to_s
      end
    end

    def full_url
      endpoint.to_s + path.to_s
    end

    def timestamp
      # digits number: 13
      # e.x.) 1531632081423
      @timestamp ||= Time.now.strftime('%s%L').to_i.to_s
    end

    def query_string
      # sort by alphabet ASC
      # https://developer.fcoin.com/jp.html?javascript#
      query_string = Hash[ payload.sort ].to_query
      query_string.blank? ? '' : query_string
    end
  end
end

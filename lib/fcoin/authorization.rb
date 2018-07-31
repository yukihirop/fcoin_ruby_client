require 'openssl'
require 'base64'
require 'active_support'
require 'active_support/core_ext'

module Fcoin
  class Authorization
    # @param http_method [String]
    # @param path [String]
    # @param payload [Hash]
    # @param endpoint [String]
    # @api_key [String]
    # @secret_key [String]
    def initialize(http_method:, path:, payload:, endpoint:, api_key:, secret_key:)
      self.http_method = http_method
      self.path        = path
      self.payload     = payload
      self.endpoint    = endpoint
      self.api_key     = api_key
      self.secret_key  = secret_key
    end

    # Header required for authentication
    #
    # @see https://developer.fcoin.com/zh.html#32c808cbe5
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

    # @example HTTP_METHOD + HTTP_REQUEST_URI + TIMESTAMP + POST_BODY
    #  POSThttps://api.fcoin.com/v2/orders1523069544359amount=100.0&price=100.0&side=buy&symbol=btcusdt&type=limit
    #
    # @see https://developer.fcoin.com/zh.html#api
    def signature
      if http_method == :get && query_string.present?
        http_method.upcase.to_s + full_url.to_s + '?' +query_string.to_s + timestamp.to_s
      else
        http_method.upcase.to_s + full_url.to_s + timestamp.to_s + payload_string.to_s
      end
    end

    def full_url
      endpoint.to_s + path.to_s
    end

    # digits number: 13
    #
    # @note When accessing the API with the UNIX EPOCH timestamp, the time difference between the server and the server must be less than 30 seconds.
    #
    # @example
    #  1531632081423
    #
    #
    # @see https://developer.fcoin.com/zh.html#api
    def timestamp
      # digits number: 13
      # e.x.) 1531632081423
      @timestamp ||= Time.now.strftime('%s%L').to_i.to_s
    end

    # sort by alphabet ASC
    #
    # @see https://developer.fcoin.com/jp.html?javascript#
    def query_string
      query_string = Hash[ payload.sort ].to_query
      query_string.blank? ? '' : query_string
    end
    alias :payload_string :query_string
  end
end

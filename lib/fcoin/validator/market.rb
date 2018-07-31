require_relative 'utility'

module Fcoin
  class MarketValidator
    include ValidatorUtility

    # @params params [Hash] Parameter you want to verify including the called method name
    # @option params :level [String or Symbol] Level of depth chart
    # @option params :resolution [String or Symbol] period of Candles Chart
    # @option params :method_name [String or Symbol] invoked method name
    def initialize(params)
      self.level       = params[:level]
      self.resolution  = params[:resolution]
      self.method_name = params[:method_name]
    end

    # Validate according to method_name
    def valid?
      case method_name
      when /market_depth|on_depth/
        valid_level?
      when /market_candles|on_candle/
        valid_resolution?
      end
    end

    # Error message when invalid
    def messages
      return {} if valid?
      results = []
      case method_name
      when /market_depth|on_depth/
        results << includes_error_message(level, :level, valid_levels) unless valid_level?
      when /market_candles|on_candle/
        results << includes_error_message(resolution, :resolution, valid_resolutions) unless valid_resolution?
      end
      results.compact&.each_with_object({}) { |message, data| data.merge!(message) }
    end

    private

    attr_accessor :level, :resolution, :method_name

    def valid_level?
      level.to_s.in? valid_levels
    end

    def valid_resolution?
      resolution.to_s.in? valid_resolutions
    end

    def valid_levels
      ::Settings.fcoin.validation.query.level
    end

    def valid_resolutions
      ::Settings.fcoin.validation.query.resolution
    end
  end
end

require_relative 'utility'
require 'pry'

module Fcoin
  class MarketValidator
    include ValidatorUtility

    def initialize(params)
      self.level       = params[:level]
      self.resolution  = params[:resolution]
      self.method_name = params[:method_name]
    end

    def valid?
      case method_name
      when /market_depth|on_depth/
        valid_level?
      when /market_candles|on_candle/
        valid_resolution?
      end
    end

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

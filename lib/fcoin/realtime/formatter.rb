require_relative 'formatter/ticker_formatter.rb'
require_relative 'formatter/depth_formatter.rb'

module Fcoin
  module RealTime
    class Formatter
      def initialize(data)
        self.data = data
      end

      def self.build(data)
        if use_formatter?(data)
          case data["type"]
          when /ticker/
            TickerFormatter.new(data)
          when /depth/
            DepthFormatter.new(data)
          else
            new(data)
          end
        else
          new(data)
        end
      end

      def formatted_data
        data
      end

      private

      attr_accessor :data

      def self.use_formatter?(data)
        data['type'].present?
      end
    end
  end
end

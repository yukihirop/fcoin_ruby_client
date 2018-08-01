require_relative 'formatter/ticker_formatter.rb'
require_relative 'formatter/depth_formatter.rb'

module Fcoin
  module RealTime
    class Formatter
      def initialize(data)
        self.data = data
      end

      # Format data
      def formatted_data
        formatter.present? ? formatter.formatted_data : data
      end

      private

      attr_accessor :data

      def formatter
        if use_formatter?(data)
          case data["type"]
          when /ticker/
            TickerFormatter.new(data)
          when /depth/
            DepthFormatter.new(data)
          else
            nil
          end
        else
          nil
        end
      end

      def use_formatter?(data)
        data['type'].present?
      end
    end
  end
end

module Fcoin
  module Validation
    module Market
      def market_depth_schema
        Dry::Validation.Schema do
          configure do
            def valid_levels
              ::Settings.fcoin.validation.query.level
            end
          end

          required(:level).maybe(:str?)
          required(:level).filled(included_in?: valid_levels)
        end
      end
      alias :on_depth_schema :market_depth_schema

      def market_candles_schema
        Dry::Validation.Schema do
          configure do
            def valid_resolutions
              ::Settings.fcoin.validation.query.resolution
            end
          end

          required(:resolution).maybe(:str?)
          required(:resolution).filled(included_in?: valid_resolusions)
        end
      end
      alias :on_candle_schema :market_candles_schema
    end
  end
end
require 'fcoin'

RSpec.configure do |config|
  # http://qaru.site/questions/1203551/how-to-access-tag-filters-in-a-beforesuitebeforeall-hook-in-rspec
  config.before :suite do
    if config.filter.rules[:fcoin_auth]
      Fcoin.configure do |fconfig|
        fconfig.api_key    = ENV['FCOIN_API_KEY']
        fconfig.secret_key = ENV['FCOIN_SECRET_KEY']
      end
    end
  end
end

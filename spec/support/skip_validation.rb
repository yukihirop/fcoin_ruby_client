require 'fcoin'

RSpec.configure do |config|
  # http://qaru.site/questions/1203551/how-to-access-tag-filters-in-a-beforesuitebeforeall-hook-in-rspec
  config.before :suite do
    Fcoin.configure do |fconfig|
      fconfig.skip_validation = false
    end
  end
end

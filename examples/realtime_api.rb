require 'bundler/setup'
require './lib/fcoin.rb'
require 'pry'

Fcoin.configure do |config|
  config.api_key    = ENV['FCOIN_API_KEY']
  config.secret_key = ENV['FCOIN_SECRET_KEY']
  config.skip_validation = false
  ## Please execute 「bundle exec fcoin validation init --path ./config」
  config.validation_setting_path = File.expand_path('../../config/my_settings.yml', __FILE__)
end

client = Fcoin::RealTime::Client.new
# client = Fcoin::RealTime::Client.new(api_key: 'hoge', secret_key: 'fuga')
# or
# client = Fcoin::Client.new.realtime


client.on_ticker(symbol: :ethusdt) do |data|
  puts data
end

client.on_depth(symbol: :ethusdt, level: :L20) do |data|
  puts data
end

client.on_trade(symbol: :ethusdt, limit: 5) do |data|
  puts data
end

client.on_candle(symbol: :ethusdt, resolution: :M1, limit: 5) do |data|
  puts data
end

client.on_topics do |data|
  puts data
end

client.on_hello do |data|
  puts data
end

client.subscribe

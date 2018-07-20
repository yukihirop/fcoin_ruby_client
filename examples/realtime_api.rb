require 'bundler/setup'
require './lib/fcoin.rb'
require 'pry'

Fcoin.configure do |config|
  config.api_key    = ENV['FCOIN_API_KEY']
  config.secret_key = ENV['FCOIN_SECRET_KEY']
end

client = Fcoin::RealTime::Client.new
# client = Fcoin::RealTime::Client.new(api_key: 'hoge', secret_key: 'fuga')
# or
# client = Fcoin::Client.new.realtime


client.on_ticker(symbol: :ethusdt) do |data|
  puts data
end

client.on_depth(level: :L20, symbol: :ethusdt) do |data|
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

# client.on('ticker.ethusdt') do |data|
#   puts data
# end

# client.on('depth.L20.uthusdt') do |data|
#   puts data
# end

# client.on('trade.ethusdt', 5) do |data|
#   puts data
# end

# client.on('candle.M1.ethusdt', 5) do |data|
#   puts data
# end

# client.on('topics') do |data|
#   puts data
# end

# client.on('hello') do |data|
#   puts data
# end

client.subscribe

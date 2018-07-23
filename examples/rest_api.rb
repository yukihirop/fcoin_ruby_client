require 'bundler/setup'
require './lib/fcoin.rb'
require 'pry'

Fcoin.configure do |config|
  config.api_key    = ENV['FCOIN_API_KEY']
  config.secret_key = ENV['FCOIN_SECRET_KEY']
end

client = Fcoin::Client.new
# client = Fcoin::Client.new(api_key: 'hoge', secret_key: 'fuga')

# ## public
# puts client.public_server_time
# puts client.public_currencies
# puts client.public_symbols


# ## market
# puts client.market_ticker(symbol: :ethusdt)
# puts client.market_depth(level: :L20 ,symbol: :ethusdt)
# puts client.market_trades(symbol: :ethusdt)
# puts client.market_candles(symbol: :ethusdt, resolution: :M1)


# ## accounts
# puts client.accounts_balance


# ## orders
client.create_order(symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001)
# puts client.order_list(symbol: :ethusdt, states: :canceled, page_before: nil, page_after: nil, per_page: 20)

# puts client.order(order_id: "L7rbALEIoI0ymo3uOXBF4gT4Bl********jvptIv2U=")
# # alias method
# # client.reference_order(order_id: "L7rbALEIoI0ymo3uOXBF4gT4Bl********jvptIv2U=")

# puts client.cancel_order(order_id: "nMEC_VrW0LYlP4iCcWzmdL50jFrvNWZoaQxvZSjeUSA=")

# puts client.order_match_results(order_id: "kW3cRiXIGHG-cHNdter*********qfoMzbeHEQcqp4=")
# # alias method
# # client.order_transaction(order_id: "kW3cRiXIGHG-cHNdter*********qfoMzbeHEQcqp4=")

puts client.market_depth(level: :L40 ,symbol: :ethusdt)
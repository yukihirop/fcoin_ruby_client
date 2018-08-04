# FcoinRubyClient
[![Build Status](https://travis-ci.org/yukihirop/fcoin_ruby_client.svg?branch=master)](https://travis-ci.org/yukihirop/fcoin_ruby_client)
[![Coverage Status](https://coveralls.io/repos/github/yukihirop/fcoin_ruby_client/badge.svg?branch=master)](https://coveralls.io/github/yukihirop/fcoin_ruby_client?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/098a36b2ed22f3a9e627/maintainability)](https://codeclimate.com/github/yukihirop/fcoin_ruby_client/maintainability)

This gem provides a ruby ​​client of [FCOIN](https://www.fcoin.com/) REST API and WebSocket API.

Very easy to use.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fcoin_ruby_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fcoin_ruby_client

## Usage
Configure default settings.
You can use all API at least by setting `api_key` and `secret_key` .
Because `api_key` and `secret_key` are confidential information,
we recommend that you read from environment variables.

```ruby
require 'fcoin'

# Authentication is done
Fcoin.configure do |config|
  config.api_key    = ENV['FCOIN_API_KEY']
  config.secret_key = ENV['FCOIN_SECRET_KEY']
end

# If you want to use the REST API
client = Fcoin::Client.new

# For example, get ticker information of ethusdt
puts client.market_ticker(symbol: :ethusdt)
#=> {"status"=>0, "data"=>{"ticker"=>{"latest_price"=>469.43, "most_recent_trade_vol"=>0.002, "max_buy_price"=>469.43, "max_buy_amount"=>7.6318, "min_sell_price"=>469.44, "min_sell_amount"=>0.0011, "trade_price_yesterday"=>468.75, "highest_price_today"=>472.0, "lowest_price_today"=>461.76, "symbol_base_vol_today"=>44442.419672207, "symbol_base_price_today"=>20784202.592831347}, "type"=>"ticker.ethusdt", "seq"=>100521295}}

```


If you want to see more usage, please see [examples](https://github.com/yukihirop/fcoin_ruby_client/tree/master/examples).
write how to use WebSocket API.

## CLI
We also prepare configuration files and provide CLI commands to execute API.
Describe the CLI command for preparing the setting file.
See [CLI example](https://github.com/yukihirop/fcoin_ruby_client/tree/master/examples/cli) for the CLI command to execute the API.

- `bundle exec fcoin validation init --path ./config`

  Create validation setting file in ./config.
　This setting file is used to set the validation.

- `bundle exec fcoin locale init --path ./cofig`

  Create locale file in ./config.
  For example, use in rails project.


If you want to know setting file, please see [config](https://github.com/yukihirop/fcoin_ruby_client/tree/master/lib/fcoin/config)

## Authorization
There are two authentication methods as follows.

#### 1. case when Fcoin

```ruby
# Authentication is done when using the REST API
Fcoin.configure do |config|
  config.api_key    = ENV['FCOIN_API_KEY']
  config.secret_key = ENV['FCOIN_SECRET_KEY']
end
```

#### 2. case when Fcoin::Client

```ruby
# Authentication is done when using the REST API
Fcoin::Client.new(api_key: ENV['FCOIN_API_KEY'], secret_key: ENV['FCOIN_SECRET_KEY'])
```


When using REST API with multiple files, we recommend that you use `Fcoin.configure(&block)` to authenticate.

## Validation
To prevent unexpected orders and　don't run invalid API,This gem is made to validate before executing the API.

1. `bundle exec validation init --path ./config`
2. Since there is `skip_validation(default: true)` in the setting, set it to `false`.
3. Since there is `validation_setting_path` in the setting, set it to `/path/to/your/my_settings.yml`

```diff
Fcoin.configure do |config|
  config.api_key    = ENV['FCOIN_API_KEY']
  config.secret_key = ENV['FCOIN_SECRET_KEY']
+ config.skip_validation = false
+ config.validation_setting_path = File.expand_path('../../config/my_settings.yml', __FILE__)
end
```

Of course you can do this as well:

```ruby
Fcoin::Client.new(skip_validation: false, validation_setting_path: File.expand_path('../../config/my_settings.yml', __FILE__))
```

- 🚨 Since `my_settings.yml` is set appropriately, __please rewrite it appropriately.__ 🚨
- 🚨 __Please do not change the structure of `my_settings.yml`.__ Can't parse and a runtime error occurs. 🚨


## Customize my_settings.yml
We present some cases.

- case 1: If you wan't to be able to `buy(limit)` on `ethusdt` board (Mainboard A) in `1000 or more amount` and `1000usdt or more price`.
- case 2: If you wan't to be able to `sell(limit)` on `ftusdt` board (Mainboard B) in `1000 or more amount` and `0.01usdt or more price`.

#### case 1
If you wan't to be able to `buy(limit)` on `ethusdt` board (Mainboard A) in `1000 or more amount` and `1000usdt or more price`.

```diff
fcoin:
  validation:
    limit:
      buy:
        mainboard_A:
+         - { symbol: 'ethusdt', amount: { min: 0, max: 1000 }, price: { min: 0, max: 10000 } }
```

#### case 2
If you wan't to be able to `sell(limit)` on `ftusdt` board (Mainboard B) in `1000 or more amount` and `0.01usdt or more price`.

```diff
fcoin:
  validation:
    limit:
      sell:
        mainboard_B:
+         - { symbol: 'ftusdt', amount: { min: 0, max: 1000 }, price: { min: 0, max: 0.01 } }
```

Of course you can also set for `GPM` currencies.


## Configure
we explain the parameters that can be set.

|option|description|
|------|------------------------------------|
|adapter|default is Faraday.default_adapter.|
|endpoint|FCOIN REST API endpoint.<br> default is `https://api.fcoin.com/v2/`|
|wss_endpoint|FCOIN WebSocket API endpoint.<br>default is `wss://api.fcoin.com/v2/ws`|
|user_agent|default is `"Fcoin Ruby Gem #{Fcoin::VERSION}".freeze` |
|proxy| Faraday proxy.<br> Please see this [document](https://github.com/lostisland/faraday#proxy)|
|middlewares|Array with a [FaradayMiddleware](https://github.com/lostisland/faraday#writing-middleware) as an element.<br> Must be request middleware.|
|api_key|FCOIN API Public Key. Please see [FCOIN document](https://developer.fcoin.com/zh.html)|
|secret_key|FCOIN API Secret Key. Please see [FCOIN document](https://developer.fcoin.com/zh.html)|
|skip_validation|Setting it to true will skip the validation. default is `true`|
|validation_setting_path|Setting file path for validation.|
|format_type|Output format. default is `:hash` (This mean `ruby Hash`)|


## Development
There are test that require authentication and others that do not.
To run the test, do the following.

```bash
$ # Test without authentication
$ bundle exec rspec
$ #
$ # Test with authentication
# # The environment variable name must be this name
$ export FCOIN_API_KEY='your fcoin api key'
$ export FCOIN_SECRET_KEY='your fcoin secret key'
$ bundle exec rspec --tag fcoin_auth

```

## Contributing

1. Fork it ( http://github.com/yukihirop/fcoin_ruby_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

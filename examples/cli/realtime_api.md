# RealTime API CLI

In development, please use the `./exe/fcoin`.<br>
In Actual, please use the `bundle exec fcoin`.

## All
```
$ ./exe/fcoin
Commands:
  fcoin account         # Get Account Information
  fcoin help [COMMAND]  # Describe available commands or one specific command
  fcoin locale          # Locale Setting
  fcoin market          # Get Market Information
  fcoin order           # Operate Order
  fcoin public          # Get Public Information
  fcoin subscribe       # Subscribe topic
  fcoin validation      # Validation Setting
  fcoin version         # Print Version

```

__If you want to validate__

```bash
$ # For more settings
$ # @see https://github.com/yukihirop/fcoin_ruby_client#validation
$ ./exe/fcoin validation init --path ./config
      create
      create  my_settings.yml
$ export VALIDATION_SETTING_PATH='/path/to/your/my_settings.yml'
```

## Subscribe
```bash
$ ./exe/fcoin subscribe
Commands:
  fcoin subscribe candle --resolution=RESOLUTION --symbol=SYMBOL  # Subscribe to candle information
  fcoin subscribe depth --level=LEVEL --symbol=SYMBOL             # Subscribe to depth information
  fcoin subscribe hello                                           # Subscribe to server time
  fcoin subscribe help [COMMAND]                                  # Describe subcommands or one specific subcommand
  fcoin subscribe ticker --symbol=SYMBOL                          # Subscribe to ticker information
  fcoin subscribe topics                                          # Subscribe to topics
  fcoin subscribe trade --symbol=SYMBOL                           # Subscribe to trade information

```

```bash
$ # Subscribe to ticker information
$ ./exe/fcoin subscribe ticker --symbol ethusdt
{"ticker":{"latest_price":417.64,"most_recent_trade_vol":0.2452,"max_buy_price":417.64,"max_buy_amount":0.0824,"min_sell_price":417.65,"min_sell_amount":0.1744,"trade_price_yesterday":399.39,"highest_price_today":420.01,"lowest_price_today":399.17,"symbol_base_vol_today":13500.553485427,"symbol_base_price_today":5568704.350213625},"type":"ticker.ethusdt","seq":105644599}
{"ticker":{"latest_price":417.64,"most_recent_trade_vol":0.2452,"max_buy_price":417.64,"max_buy_amount":0.0824,"min_sell_price":417.65,"min_sell_amount":0.1744,"trade_price_yesterday":399.39,"highest_price_today":420.01,"lowest_price_today":399.17,"symbol_base_vol_today":13500.553485427,"symbol_base_price_today":5568704.350213625},"type":"ticker.ethusdt","seq":105644607}
...
...
$ # Subscribe to depth information
$ ./exe/fcoin subscribe depth --symbol ethusdt --level L20
{"bids":[{"price":417.65,"amount":0.4365},{"price":417.6,"amount":8.282},{"price":417.57,"amount":9.5453},{"price":417.56,"amount":0.0404},{"price":417.55,"amount":0.0064},{"price":417.54,"amount":0.0016},{"price":417.53,"amount":0.0016},{"price":417.5,"amount":2.5845},{"price":417.48,"amount":0.0092},{"price":417.42,"amount":0.02},{"price":417.3,"amount":0.005},{"price":417.1,"amount":0.005},{"price":417.07,"amount":0.0655},{"price":417.03,"amount":0.0039},{"price":417.01,"amount":2.538},{"price":417.0,"amount":0.6005},{"price":416.98,"amount":0.0528},{"price":416.97,"amount":3.0},{"price":416.93,"amount":0.3},{"price":416.9,"amount":0.005}],"asks":[{"price":417.68,"amount":0.0166},{"price":417.69,"amount":0.0016},{"price":417.7,"amount":0.9476},{"price":417.71,"amount":0.0128},{"price":417.72,"amount":0.1234},{"price":417.82,"amount":0.0023},{"price":417.83,"amount":0.0171},{"price":417.86,"amount":0.0141},{"price":417.88,"amount":0.02},{"price":417.9,"amount":0.0075},{"price":417.91,"amount":0.01},{"price":418.1,"amount":0.005},{"price":418.24,"amount":0.931},{"price":418.3,"amount":0.005},{"price":418.35,"amount":0.1},{"price":418.4,"amount":0.1},{"price":418.45,"amount":14.77605139},{"price":418.46,"amount":0.1033},{"price":418.49,"amount":0.0065},{"price":418.5,"amount":0.505}],"ts":1533358172008,"seq":105645076,"type":"depth.L20.ethusdt"}
{"bids":[{"price":417.65,"amount":0.4365},{"price":417.6,"amount":8.282},{"price":417.57,"amount":9.5453},{"price":417.56,"amount":0.0404},{"price":417.55,"amount":0.0064},{"price":417.54,"amount":0.0016},{"price":417.53,"amount":0.0016},{"price":417.5,"amount":2.5845},{"price":417.48,"amount":0.0092},{"price":417.42,"amount":0.02},{"price":417.3,"amount":0.005},{"price":417.1,"amount":0.005},{"price":417.07,"amount":0.0655},{"price":417.03,"amount":0.0039},{"price":417.01,"amount":2.438},{"price":417.0,"amount":0.6005},{"price":416.98,"amount":0.0528},{"price":416.97,"amount":3.0},{"price":416.93,"amount":0.3},{"price":416.9,"amount":0.005}],"asks":[{"price":417.68,"amount":0.0166},{"price":417.69,"amount":0.0016},{"price":417.7,"amount":0.9476},{"price":417.71,"amount":0.0128},{"price":417.72,"amount":0.1234},{"price":417.82,"amount":0.0023},{"price":417.83,"amount":0.0171},{"price":417.86,"amount":0.0141},{"price":417.88,"amount":0.02},{"price":417.9,"amount":0.0075},{"price":417.91,"amount":0.01},{"price":418.1,"amount":0.005},{"price":418.24,"amount":0.931},{"price":418.3,"amount":0.005},{"price":418.35,"amount":0.1},{"price":418.4,"amount":0.1},{"price":418.45,"amount":14.77605139},{"price":418.46,"amount":0.1033},{"price":418.49,"amount":0.0065},{"price":418.5,"amount":0.505}],"ts":1533358173008,"seq":105645077,"type":"depth.L20.ethusdt"}
...
...
$ # Subscribe to trade information
$ ./exe/fcoin subscribe trade --symbol ethusdt
{"amount":0.1891,"type":"trade.ethusdt","ts":1533358225453,"id":105645412000,"side":"sell","price":417.6}
{"amount":0.3944,"type":"trade.ethusdt","ts":1533358234398,"id":105645473000,"side":"sell","price":417.6}
...
...
$ # Subscribe to candle information
$ ./exe/fcoin subscribe candle --symbol ethusdt --resolution MN
{"open":430.1,"type":"candle.MN.ethusdt","close":417.61,"high":435.93,"quote_vol":51514255.299988344,"id":1533052800,"count":390173,"low":397.61,"seq":10564587100000,"base_vol":122629.972229052}
{"open":430.1,"type":"candle.MN.ethusdt","close":417.61,"high":435.93,"quote_vol":51516631.99998658,"id":1533052800,"count":390174,"low":397.61,"seq":10564590200000,"base_vol":122635.663424182}
...
...
$ # Subscribe to topics
$ ./exe/fcoin subscribe topics
{"id":"61daeff4-36e4-4423-a4e4-adb158accadf","type":"topics","topics":[]}
$ # Subscribe to server time
$ ./exe/fcoin subscribe hello
{"type":"hello","ts":1533358407476} 
```
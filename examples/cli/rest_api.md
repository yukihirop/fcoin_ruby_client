# REST API CLI

In development, please use the `./exe/fcoin`.<br>
In Actual, please use the `fcoin`.

## All
```bash
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

## Public
```bash
$ ./exe/fcoin public
Commands:
  fcoin public currencies      # Display available currency
  fcoin public help [COMMAND]  # Describe subcommands or one specific subcommand
  fcoin public server_time     # Get server time
  fcoin public symbols         # Query available transaction pairs

```

```bash
$ # Get server time
$ ./exe/fcoin public server_time
{"status":0,"data":1533311785257}
$
$ # Display available currency
$ ./exe/fcoin public currencies
{"status":0,"data":["btc","eth","bch","ltc","eos","usdt","ft_frozen","ft","zip","etc","omg","btm","zrx","xrp","bnb","gtc","fi","zil","icx","ae","777","gus","cccx","banca","pra","dcc","sss","mdt","tst","pmd","rte","xps","tct","dws","ngot","at","soc","blz","ocn","datx","let","dag","yee","aaa","nc","ait","arp","gram","tbcoin","ifood","hpc","sgcc","lxt","3db","drink1","drink","drct","ionc","xmx","rct","cit","ees","fair","brm","sda","cbr","tkt","vct","biz","show","pai","sec","lovc","mst","iov","ejoy","iht","iic","fbc","fota","dagt","wte","tos","oas","fres","gene","maya","mesh","icc","scl","cofi","but","zsc","jac","vns","aidoc","ccc","fuel","edu","beauty","mof","dta","cps","msc","latx","dscoin","dscb","boc","18t","newos","mxm","idxe","pnt","vpp","lmm","rnt","hotc","fff","dht","fbee","vlc","wicc","mot","bcv","baic","ruff","ink","ges","sac","see","dpn","smt","musk","ptt","mith","lth","wmch","cwv","jll","bhpc","unc","int","insur","pun","facc","osch","uto","btmc","cnmc","fcandy","dacc","fti","bbc","orme","tcash","mitx","pok","icst","gu","iota","ft1808","ft1810_i","zpr","nrc","kan","dac","eai","ifish","tat","you","win","fish","box","cosm","loom","kcash","rrc","olt","agi","kora","skm","bto","uuu","gse","bft","abt","mds","ors","vaac","lba","knc","gto","bfdt","est","gnx","iost","hpb","xin","cai","tac","risk","vnt","vboom","ugc","ole","bkbt","cpc","qos"]}
$
$ # Query available transaction pairs
$ ./exe/fcoin public symbols
{"status":0,"data":[{"name":"btcusdt","base_currency":"btc","quote_currency":"usdt","price_decimal":2,"amount_decimal":4},{"name":"ethusdt","base_currency":"eth","quote_currency":"usdt","price_decimal":2,"amount_decimal":4},{"name":"bchusdt","base_currency":"bch","quote_currency":"usdt","price_decimal":2,"amount_decimal":4},{"name":"ltcusdt","base_currency":"ltc","quote_currency":"usdt","price_decimal":2,"amount_decimal":4},{"name":"ftusdt","base_currency":"ft","quote_currency":"usdt","price_decimal":6,"amount_decimal":2},{"name":"fteth","base_currency":"ft","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"zipeth","base_currency":"zip","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"etcusdt","base_currency":"etc","quote_currency":"usdt","price_decimal":2,"amount_decimal":4},{"name":"ftbtc","base_currency":"ft","quote_currency":"btc","price_decimal":8,"amount_decimal":2},{"name":"omgeth","base_currency":"omg","quote_currency":"eth","price_decimal":6,"amount_decimal":4},{"name":"btmusdt","base_currency":"btm","quote_currency":"usdt","price_decimal":4,"amount_decimal":2},{"name":"zrxeth","base_currency":"zrx","quote_currency":"eth","price_decimal":6,"amount_decimal":2},{"name":"bnbusdt","base_currency":"bnb","quote_currency":"usdt","price_decimal":4,"amount_decimal":2},{"name":"zipusdt","base_currency":"zip","quote_currency":"usdt","price_decimal":6,"amount_decimal":2},{"name":"xrpusdt","base_currency":"xrp","quote_currency":"usdt","price_decimal":4,"amount_decimal":2},{"name":"fieth","base_currency":"fi","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"fiusdt","base_currency":"fi","quote_currency":"usdt","price_decimal":6,"amount_decimal":2},{"name":"icxeth","base_currency":"icx","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"zileth","base_currency":"zil","quote_currency":"eth","price_decimal":6,"amount_decimal":4},{"name":"aeeth","base_currency":"ae","quote_currency":"eth","price_decimal":6,"amount_decimal":2},{"name":"777eth","base_currency":"777","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"guseth","base_currency":"gus","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"cccxeth","base_currency":"cccx","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"bancaeth","base_currency":"banca","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"praeth","base_currency":"pra","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"dcceth","base_currency":"dcc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ssseth","base_currency":"sss","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"mdteth","base_currency":"mdt","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"tsteth","base_currency":"tst","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"pmdeth","base_currency":"pmd","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"rteeth","base_currency":"rte","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"xpseth","base_currency":"xps","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"tcteth","base_currency":"tct","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"dwseth","base_currency":"dws","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ngoteth","base_currency":"ngot","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ateth","base_currency":"at","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"soceth","base_currency":"soc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"blzeth","base_currency":"blz","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ocneth","base_currency":"ocn","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"datxeth","base_currency":"datx","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"gtceth","base_currency":"gtc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"leteth","base_currency":"let","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"dageth","base_currency":"dag","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"yeeeth","base_currency":"yee","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"aaaeth","base_currency":"aaa","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"nceth","base_currency":"nc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"aiteth","base_currency":"ait","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"arpeth","base_currency":"arp","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"grameth","base_currency":"gram","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ifoodeth","base_currency":"ifood","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"hpceth","base_currency":"hpc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"sgcceth","base_currency":"sgcc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"3dbeth","base_currency":"3db","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"xmxeth","base_currency":"xmx","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"rcteth","base_currency":"rct","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"citeth","base_currency":"cit","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"eeseth","base_currency":"ees","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"faireth","base_currency":"fair","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"brmeth","base_currency":"brm","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"sdaeth","base_currency":"sda","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"cbreth","base_currency":"cbr","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"tkteth","base_currency":"tkt","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"vcteth","base_currency":"vct","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"bizeth","base_currency":"biz","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"showeth","base_currency":"show","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"paieth","base_currency":"pai","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ioveth","base_currency":"iov","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ihteth","base_currency":"iht","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"fotaeth","base_currency":"fota","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ejoyeth","base_currency":"ejoy","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"iiceth","base_currency":"iic","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"wteeth","base_currency":"wte","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"freseth","base_currency":"fres","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"mesheth","base_currency":"mesh","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"icceth","base_currency":"icc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ionceth","base_currency":"ionc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"drcteth","base_currency":"drct","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"oaseth","base_currency":"oas","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"buteth","base_currency":"but","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"aidoceth","base_currency":"aidoc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"cofieth","base_currency":"cofi","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"lxteth","base_currency":"lxt","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"edueth","base_currency":"edu","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"dtaeth","base_currency":"dta","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"msceth","base_currency":"msc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"geneeth","base_currency":"gene","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ccceth","base_currency":"ccc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"dscoineth","base_currency":"dscoin","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"boceth","base_currency":"boc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"toseth","base_currency":"tos","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"fueleth","base_currency":"fuel","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"pnteth","base_currency":"pnt","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"seceth","base_currency":"sec","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"mofeth","base_currency":"mof","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"rnteth","base_currency":"rnt","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"wicceth","base_currency":"wicc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"fffeth","base_currency":"fff","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"cpseth","base_currency":"cps","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"zsceth","base_currency":"zsc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"latxeth","base_currency":"latx","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"dhteth","base_currency":"dht","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"seeeth","base_currency":"see","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"inketh","base_currency":"ink","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"saceth","base_currency":"sac","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"scleth","base_currency":"scl","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"mitheth","base_currency":"mith","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"smteth","base_currency":"smt","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"fcandyusdt","base_currency":"fcandy","quote_currency":"usdt","price_decimal":8,"amount_decimal":2},{"name":"newoseth","base_currency":"newos","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"hotceth","base_currency":"hotc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ptteth","base_currency":"ptt","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"dpneth","base_currency":"dpn","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ltheth","base_currency":"lth","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"jlleth","base_currency":"jll","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"utoeth","base_currency":"uto","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"777usdt","base_currency":"777","quote_currency":"usdt","price_decimal":8,"amount_decimal":2},{"name":"xpsusdt","base_currency":"xps","quote_currency":"usdt","price_decimal":8,"amount_decimal":2},{"name":"prausdt","base_currency":"pra","quote_currency":"usdt","price_decimal":8,"amount_decimal":2},{"name":"hpcusdt","base_currency":"hpc","quote_currency":"usdt","price_decimal":8,"amount_decimal":2},{"name":"vppeth","base_currency":"vpp","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"oscheth","base_currency":"osch","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"guusdt","base_currency":"gu","quote_currency":"usdt","price_decimal":8,"amount_decimal":2},{"name":"ft1808usdt","base_currency":"ft1808","quote_currency":"usdt","price_decimal":6,"amount_decimal":2},{"name":"ruffeth","base_currency":"ruff","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"baiceth","base_currency":"baic","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ormeeth","base_currency":"orme","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"puneth","base_currency":"pun","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"facceth","base_currency":"facc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"cwveth","base_currency":"cwv","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"lmmeth","base_currency":"lmm","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"vlceth","base_currency":"vlc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"icsteth","base_currency":"icst","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ftft1808","base_currency":"ft","quote_currency":"ft1808","price_decimal":6,"amount_decimal":2},{"name":"iotausdt","base_currency":"iota","quote_currency":"usdt","price_decimal":4,"amount_decimal":2},{"name":"drink1eth","base_currency":"drink1","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"drinketh","base_currency":"drink","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"musketh","base_currency":"musk","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"mxmeth","base_currency":"mxm","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"mitxeth","base_currency":"mitx","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ft1810_iusdt","base_currency":"ft1810_i","quote_currency":"usdt","price_decimal":6,"amount_decimal":2},{"name":"ftft1810_i","base_currency":"ft","quote_currency":"ft1810_i","price_decimal":6,"amount_decimal":2},{"name":"inteth","base_currency":"int","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"btmceth","base_currency":"btmc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"cnmceth","base_currency":"cnmc","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"ftieth","base_currency":"fti","quote_currency":"eth","price_decimal":8,"amount_decimal":2},{"name":"eosusdt","base_currency":"eos","quote_currency":"usdt","price_decimal":4,"amount_decimal":4}]}
```

## Market
```bash
$ ./exe/fcoin market
Commands:
  fcoin market candles --resolution=RESOLUTION --symbol=SYMBOL  # Returns candles info of symbol specified by resolution
  fcoin market depth --level=LEVEL --symbol=SYMBOL              # Returns depth info of symbol specified by level
  fcoin market help [COMMAND]                                   # Describe subcommands or one specific subcommand
  fcoin market ticker --symbol=SYMBOL                           # Returns ticker info of symbol
  fcoin market trades --symbol=SYMBOL                           # Returns trades info of symbol

```

```bash
$ # Returns ticker info of symbol
$ ./exe/fcoin market ticker --symbol ethusdt
{"status":0,"data":{"ticker":{"latest_price":414.02,"most_recent_trade_vol":0.0902,"max_buy_price":414.02,"max_buy_amount":1.8507,"min_sell_price":414.03,"min_sell_amount":0.5,"trade_price_yesterday":412.04,"highest_price_today":415.31,"lowest_price_today":397.61,"symbol_base_vol_today":20506.814864234,"symbol_base_price_today":8368527.290918281},"type":"ticker.ethusdt","seq":105330258}}

$ # Returns depth info of symbol specified by level
$ ./exe/fcoin market depth --symbol ethusdt --level L20
{"status":0,"data":{"bids":[{"price":414.06,"amount":0.015},{"price":414.05,"amount":0.045},{"price":414.02,"amount":0.4694},{"price":414.0,"amount":0.1042},{"price":413.94,"amount":0.0084},{"price":413.93,"amount":0.4181},{"price":413.91,"amount":0.0025},{"price":413.9,"amount":0.0242},{"price":413.81,"amount":0.0036},{"price":413.8,"amount":0.04},{"price":413.71,"amount":0.1499},{"price":413.7,"amount":0.095},{"price":413.68,"amount":0.0558},{"price":413.67,"amount":0.0803},{"price":413.66,"amount":0.0684},{"price":413.62,"amount":0.0617},{"price":413.6,"amount":0.9768},{"price":413.59,"amount":0.0469},{"price":413.5,"amount":1.6528},{"price":413.41,"amount":0.0541}],"asks":[{"price":414.08,"amount":0.1742},{"price":414.09,"amount":0.1153},{"price":414.1,"amount":0.0201},{"price":414.11,"amount":0.1566},{"price":414.13,"amount":0.1332},{"price":414.15,"amount":0.2891},{"price":414.16,"amount":0.0951},{"price":414.23,"amount":0.4024},{"price":414.27,"amount":0.0283},{"price":414.3,"amount":0.005},{"price":414.31,"amount":0.0072},{"price":414.32,"amount":0.0035},{"price":414.35,"amount":0.0072},{"price":414.36,"amount":0.0025},{"price":414.46,"amount":0.0638},{"price":414.49,"amount":1.2057},{"price":414.5,"amount":0.005},{"price":414.51,"amount":0.0105},{"price":414.53,"amount":0.0015},{"price":414.6,"amount":0.06}],"ts":1533312373012,"seq":105330896,"type":"depth.L20.ethusdt"}}

$ # Returns trades info of symbol
$ ./exe/fcoin market trades --symbol ethusdt
{"status":0,"data":[{"amount":0.0371,"ts":1533312528424,"id":105331864002,"side":"buy","price":413.8}]}

$ # Returns candles info of symbol specified by resolution
$ ./exe/fcoin market candles --symbol ethusdt --resolution MN
{"status":0,"data":[{"open":430.1,"close":413.84,"high":435.93,"quote_vol":48966834.28889369,"id":1533052800,"count":357474,"low":397.61,"seq":10533250500000,"base_vol":116515.627401974},{"id":1530374400,"seq":10277314000000,"high":516.09,"low":418.29,"open":449.1,"close":430.1,"count":6460281,"base_vol":3214156.779928503,"quote_vol":1481280928.4282734},{"id":1527782400,"seq":7385778300000,"high":555.13,"low":406.11,"open":523.97,"close":449.04,"count":20382481,"base_vol":28258854.226292703,"quote_vol":13579650310.735054},{"id":1525104000,"seq":2847062700000,"high":582.99,"low":559.66,"open":563.23,"close":575.77,"count":4617,"base_vol":4159.317883344,"quote_vol":2380070.431548223}]}
```

## Order

__Please authenticate before command execution__
```bash
export FCOIN_API_KEY='your_fcoin_api_key'
export FCOIN_SECRET_KEY='your_fcoin_secret_key'
```

```bash
$ ./exe/fcoin order
Commands:
  fcoin order cancel --order-id=ORDER_ID                                     # Cancel order
  fcoin order create_limit --amount=N --price=N --side=SIDE --symbol=SYMBOL  # Create limit order
  fcoin order help [COMMAND] --side=SIDE --symbol=SYMBOL                     # Describe subcommands or one specific subcommand
  fcoin order list --states=STATES --symbol=SYMBOL                           # Get order list
  fcoin order reference --order-id=ORDER_ID                                  # Ouery order
  fcoin order transaction --order-id=ORDER_ID                                # Query the transaction record for the specified by order_id

```

```bash
$ # Create limit order
$ ./exe/fcoin order create_limit --symbol ftusdt --side sell --price 1 --amount 3
{"status":0,"data":"6SlFV7PSsxYu0FduMlYwghCgLgjeD_AiT5loT-ZFl2s="}

$ # Ouery order
$ ./exe/fcoin order reference --order-id 6SlFV7PSsxYu0FduMlYwghCgLgjeD_AiT5loT-ZFl2s=
{"status":0,"data":{"id":"6SlFV7PSsxYu0FduMlYwghCgLgjeD_AiT5loT-ZFl2s=","symbol":"ftusdt","amount":"3.000000000000000000","price":"1.000000000000000000","created_at":1533313517068,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"submitted"}}

$ # Query the transaction record
$ ./exe/fcoin order transaction --order-id 6SlFV7PSsxYu0FduMlYwghCgLgjeD_AiT5loT-ZFl2s=
{"status":0,"data":[]}

$ # Cancel order
$ ./exe/fcoin order cancel --order-id 6SlFV7PSsxYu0FduMlYwghCgLgjeD_AiT5loT-ZFl2s=
{"status":0} # cancel is success

$ # Get order list
$ ./exe/fcoin order list --symbol ethusdt --states canceled
{"status":0,"data":[{"id":"nMEC_VrW0LYlP4iCcWzmdL50jFrvNWZoaQxvZSjeUSA=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531732778736,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"V6WE1JJCUwvqJFgCjfT5lA37ioU_xOYi6_NSrtOVOsw=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531732713230,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"R0moy92q4Qaf_GDEQ6Y1IKCgl5wwJM2bz_Zyacp-Ek8=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531714333569,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"L7rbALEIoI0ymo3uOXBF4gT4BlyTxgHhGoZjvptIv2U=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531714218130,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"32ZZCBEpPz2J9oFIJ4RMTIbypltjrVD9PAdYxQTHhUE=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531714092732,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"VotO2IKI2opgyKRd1lhR5bYj9zNZ398IW85gcBNPisU=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531712709955,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"api","state":"canceled"},{"id":"tYH6LczJxaVe_WhsLOzOk4YM53hK2q169nYn9ReiwGM=","symbol":"ethusdt","amount":"0.001000000000000000","price":"1000.000000000000000000","created_at":1531675732267,"type":"limit","side":"sell","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"web","state":"canceled"},{"id":"U50WtZkmIh_bbuVKoipAMayCIy0A7qk4hBLxpDvKdPk=","symbol":"ethusdt","amount":"0.025800000000000000","price":"491.100000000000000000","created_at":1529665880201,"type":"limit","side":"buy","filled_amount":"0.000000000000000000","executed_value":"0.000000000000000000","fill_fees":"0.000000000000000000","source":"web","state":"canceled"}]}
```

## Account

__Please authenticate before command execution__
```bash
export FCOIN_API_KEY='your_fcoin_api_key'
export FCOIN_SECRET_KEY='your_fcoin_secret_key'
```

```bash
$ ./exe/fcoin account
Commands:
  fcoin account balance         # Get account info
  fcoin account help [COMMAND]  # Describe subcommands or one specific subcommand

```

```bash
$ ./exe/fcoin account balance
# Do not display because it is personal information
```

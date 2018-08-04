# Setting CLI

## All
```bash
$ ./bin/fcoin
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

## Validation
```bash
$ # Create validation setting file
$ ./bin/fcoin validation init --path ./config
      create
      create  my_settings.yml
```

## Locale
```bash
$ # Create locale file
$ ./bin/fcoin locale init --path ./config
       exist
      create  .DS_Store
      create  locales/en.yml
      create  locales/ja.yml
      create  locales/zh_CN.yml
```

require_relative '../fcoin'
require_relative 'cli/endpoint/accounts_task'
require_relative 'cli/endpoint/market_task'
require_relative 'cli/endpoint/orders_task'
require_relative 'cli/endpoint/public_task'
require_relative 'cli/realtime/endpoint_task'

require 'thor'

module Fcoin
  class ValidationTask < Thor
    # Create validation setting file
    #
    # @example Create validation setting file in ./config
    #  ./exe/fcoin validation init --path ./config
    #     create
    #     create  my_settings.yml
    #
    #
    # @see https://nandovieira.com/creating-generators-and-executables-with-thor
    # @option [String] :path(./) Specify path where you want to create a configuration file for validation
    desc 'init', 'Create validation setting file'
    option :path, type: :string, desc: "Path that you want to copy validation setting file"
    def init
      generator = Generators::Validation.new
      generator.destination_root = options[:path] || '.'
      generator.invoke_all
    end
  end

  class LocaleTask < Thor
    # Create locale file. For example, use in rails project and so on.
    #
    # @example Create locale file in ./config
    #  ./exe/fcoin locale init --path ./config
    #     exist
    #    create  .DS_Store
    #    create  locales/en.yml
    #    create  locales/ja.yml
    #    create  locales/zh_CN.yml
    #
    #
    # @option [String] :path(./) Specify path where you want to create locales file for using rails project and so on.
    desc 'init', 'Create locale file'
    option :path, type: :string, desc: 'Path that you want to copy locale file'
    def init
      generator = Generators::Locale.new
      generator.destination_root = options[:path] || '.'
      generator.invoke_all
    end
  end

  class CLI < Thor
    # Print Version
    #
    # @example Print current version
    #  ./exe/fcoin version
    #  fconi_ruby_client v0.1.0
    desc 'version', 'Print Version'
    def version
      STDOUT.puts "fconi_ruby_client v#{Fcoin::VERSION}"
    end

    # Register as command of cli
    #
    # @see https://stackoverflow.com/questions/5663519/namespacing-thor-commands-in-a-standalone-ruby-executable
    register(Fcoin::ValidationTask,         'validation', 'validation',      'Validation Setting')
    register(Fcoin::LocaleTask,             'locale',     'locale',          'Locale Setting')
    # REST API
    register(Fcoin::EndPoint::AccountsTask, 'account',    'account',         'Get Account Information')
    register(Fcoin::EndPoint::MarketTask,   'market',     'market',          'Get Market Information')
    register(Fcoin::EndPoint::OrdersTask,   'order',      'order',           'Operate Order')
    register(Fcoin::EndPoint::PublicTask,   'public',     'public',          'Get Public Information')
    # Websocket API
    register(Fcoin::RealTime::EndPointTask, 'subscribe',  'subscribe',       'Subscribe topic')
  end
end

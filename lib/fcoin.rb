require_relative "fcoin/version"
require_relative "fcoin/configuration"
require_relative "fcoin/client"
require_relative "fcoin/realtime/client"
require 'config'

module Fcoin
  extend Configuration

  Config.load_and_set_settings([
    File.expand_path('../fcoin/config/settings.yml',__FILE__)
  ])
end

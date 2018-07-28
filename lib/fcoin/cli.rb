require_relative '../fcoin'
require 'thor'

module Fcoin
  class ValidationTask < Thor
    # https://nandovieira.com/creating-generators-and-executables-with-thor
    desc 'init', 'Create validation setting file.'
    option :path, type: :string, desc: "Path that you want to copy validation setting file."
    def init
      generator = Generators::Validation.new
      generator.destination_root = options[:path] || '.'
      generator.invoke_all
    end
  end

  class LocaleTask < Thor
    desc 'init', 'Create locale file.'
    option :path, type: :string, desc: 'Path that you want to copy locale file.'
    def init
      generator = Generators::Locale.new
      generator.destination_root = options[:path] || '.'
      generator.invoke_all
    end
  end

  class CLI < Thor

    desc 'version', 'Print Version'
    def version
      puts "fconi_ruby_client v#{Fcoin::VERSION}"
    end

    # https://stackoverflow.com/questions/5663519/namespacing-thor-commands-in-a-standalone-ruby-executable
    register(Fcoin::ValidationTask, 'validation', 'validation init', 'Create validation setting file.')
    register(Fcoin::LocaleTask, 'locale', 'locale init', 'Create locale file. For example use in rails project.')
  end
end

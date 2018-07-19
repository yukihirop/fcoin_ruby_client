require 'spec_helper'

RSpec.describe Fcoin::Configuration do
  describe '.options' do
    let(:dummy_class) do
      class Dummy
        extend Fcoin::Configuration
      end
    end

    subject { dummy_class.options }
    let(:after_initialize_options) do
      {
        :adapter     => :net_http,
        :endpoint    => 'https://api.fcoin.com/v2/',
        :wss_endpoint => "wss://api.fcoin.com/v2/ws",
        :user_agent  => "Fcoin Ruby Gem #{Fcoin::VERSION}",
        :api_key     => 'Fcoin API Public Key',
        :secret_key  => 'Fcoin API Secret Key',
        :proxy       => nil,
        :ca_path     => '/private/etc/ssl',
        :ca_file     => '/private/etc/ssl/ca-certificates.crt',
        :middlewares => []
      }
    end

    it 'should be initialized' do
      is_expected.to eq after_initialize_options
    end
  end
end

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
        :token       => nil,
        :endpoint    => 'https://api.fcoin.com/v2/',
        :user_agent  => "Fcoin Ruby Gem #{Fcoin::VERSION}",
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

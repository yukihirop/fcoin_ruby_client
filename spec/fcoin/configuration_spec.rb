require 'spec_helper'

RSpec.describe Fcoin::Configuration do
  describe '.opations' do
    let(:dummy_class) do
      class Dummy
        extend Fcoin::Configuration
      end
    end

    subject { dummy_class.options }
    let(:after_initialize_option) do
      {
        :adapter  => :net_http,
        :endpoint => "https://api.fcoin.com/v2",
        :token    => nil,
      }
    end

    it 'should eq VALID_OPTION_KEYS' do
      is_expected.to eq after_initialize_option
    end
  end
end

require 'spec_helper'

RSpec.describe Fcoin::API do
  describe '.initialize' do
    let(:api) { described_class.new(merged_options) }
    let(:merged_options) do
      {
        :adapter  => :test_http,
        :endpoint => 'https://api.fcoin.com/v3/',
        :validation_setting_path => 'path/to/your/my_settings.myl'
      }
    end

    it 'initialize by merged options' do
      expect(api.instance_variable_get(:@adapter)).to  eq :test_http
      expect(api.instance_variable_get(:@endpoint)).to eq 'https://api.fcoin.com/v3/'
      expect(api.instance_variable_get(:@validation_setting_path)).to eq 'path/to/your/my_settings.myl'
    end
  end
end

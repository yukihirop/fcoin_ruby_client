require 'spec_helper'

RSpec.describe Fcoin::Request, vcr: true do
  let(:client) { Fcoin::Client.new }

  describe '#get', vcr: { cassette_name: 'request/get', record: :new_episodes } do
    let(:body) { client.get('public/server-time') }

    it 'response data should be got' do
      expect(body['data']).to   eq 1531561469158
      expect(body['status']).to eq 0
    end
  end
end

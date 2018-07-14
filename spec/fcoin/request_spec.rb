require 'spec_helper'

RSpec.describe Fcoin::Request, vcr: true do
  let(:client) { Fcoin::Client.new }

  describe '#get', vcr: { cassette_name: 'request/get', record: :new_episodes } do
    let(:response) { client.get('public/server-time') }
    let(:body)     { JSON.parse(response.body) }

    it 'response data should be got' do
      expect(body['data']).to   eq 1531561469158
      expect(body['status']).to eq 0
    end

    it 'response status code should be got' do
      expect(response.status).to eq 200
    end
  end
end

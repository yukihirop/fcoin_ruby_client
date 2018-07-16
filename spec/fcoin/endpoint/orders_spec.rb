require 'spec_helper'

RSpec.describe Fcoin::Endpoint::Orders do
  let(:client) { Fcoin::Client.new }

  describe '#create_order' do
    context 'when client is authorized', fcoin_auth: true do
      context 'when input correct', vcr: { cassette_name: 'orders/create_order_auth', record: :new_episodes } do
        let(:response)  { client.create_order(symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001) }
        let(:body)      { JSON.parse(response.body) }

        it 'response data should be got' do
          # order_id
          expect(body['data']).to   eq "R0moy92q4Qaf_GDEQ6Y1IKCgl5wwJM2bz_Zyacp-Ek8="
          expect(body['status']).to eq 0
        end

        it 'response status code is 200' do
          expect(response.status).to eq 200
        end
      end

      context 'when input incorrect', vcr: { cassette_name: 'orders/create_order_auth_incorrect', record: :new_episodes } do
        let(:response)  { client.create_order(symbol: :ftft, side: :sell, type: :limit, price: 10, amount: 10) }
        let(:body)      { JSON.parse(response.body) }

        it 'should return error message' do
          expect(body['msg']).to    eq "invalid symbol: ftft"
          expect(body['status']).to eq 1004
        end

        it 'response status code is 200' do
          expect(response.status).to eq 400
        end
      end

      context 'when params is missing' do
        subject { client.create_order }
        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError, "missing keywords: symbol, side, type, price, amount")
        end
      end
    end

    context 'when client is not authorized', vcr: { cassette_name: 'orders/create_order_not_auth', record: :new_episodes } do
      let(:response)  { client.create_order(symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001) }
      let(:body)      { JSON.parse(response.body) }
      
      it 'should return error message' do
        expect(body['msg']).to    eq "api key check fail : {\"status\":1020,\"msg\":\"api key not found : Fcoin API Public Key\"}"
        expect(body['status']).to eq 6005
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end
  end

  describe '#order_list', fcoin_auth: true, vcr: { cassette_name: 'orders/order_list_auth', record: :new_episodes } do
    context 'when input correct' do
      let(:response)   { client.order_list(symbol: :ethusdt, states: :canceled, page_before: nil, page_after: nil, per_page: 20) }
      let(:body)       { JSON.parse(response.body) }
      let(:first_data) { body['data'].first }

      it 'response data should be got' do
        expect(first_data['id']).to             eq "L7rbALEIoI0ymo3uOXBF4gT4BlyTxgHhGoZjvptIv2U="
        expect(first_data['symbol']).to         eq "ethusdt"
        expect(first_data['amount']).to         eq "0.001000000000000000"
        expect(first_data['price']).to          eq "1000.000000000000000000"
        expect(first_data['created_at']).to     eq 1531714218130
        expect(first_data['type']).to           eq "limit"
        expect(first_data['side']).to           eq "sell"
        expect(first_data['filled_amount']).to  eq "0.000000000000000000"
        expect(first_data['executed_value']).to eq "0.000000000000000000"
        expect(first_data['fill_fees']).to      eq "0.000000000000000000"
        expect(first_data['source']).to         eq "api"
        expect(first_data['state']).to          eq "canceled"
        expect(body['status']).to               eq 0
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when input incorrect' do
      let(:response)  { client.order_list(symbol: :ftft, states: :canceled) }
      let(:body)      { JSON.parse(response.body) }

      it 'should return error message' do
        expect(body['msg']).to    eq "invalid symbol: ftft"
        expect(body['status']).to eq 1004
      end

      it 'response status code is 200' do
        expect(response.status).to eq 400
      end
    end

    context 'when symbol and states is missing' do
      subject { client.order_list }

      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError, "missing keywords: symbol, states")
      end
    end
  end

  describe '#order(reference_order)', fcoin_auth: true, vcr: { cassette_name: 'orders/reference_order_auth', record: :new_episodes } do
    context 'when input correct' do
      let(:response) { client.order(order_id: "L7rbALEIoI0ymo3uOXBF4gT4BlyTxgHhGoZjvptIv2U=") }
      let(:body)     { JSON.parse(response.body) }

      it 'response data should be got' do
        expect(body['data']['id']).to             eq "L7rbALEIoI0ymo3uOXBF4gT4BlyTxgHhGoZjvptIv2U="
        expect(body['data']['symbol']).to         eq "ethusdt"
        expect(body['data']['amount']).to         eq "0.001000000000000000"
        expect(body['data']['price']).to          eq "1000.000000000000000000"
        expect(body['data']['created_at']).to     eq 1531714218130
        expect(body['data']['type']).to           eq "limit"
        expect(body['data']['side']).to           eq "sell"
        expect(body['data']['filled_amount']).to  eq "0.000000000000000000"
        expect(body['data']['executed_value']).to eq "0.000000000000000000"
        expect(body['data']['fill_fees']).to      eq "0.000000000000000000"
        expect(body['data']['source']).to         eq "api"
        expect(body['data']['state']).to          eq "canceled"
        expect(body['status']).to                 eq 0
      end
    end

    context 'when input incorrect' do
      let(:response) { client.order(order_id: 'invalid_order_id') }
      let(:body)     { JSON.parse(response.body) }

      it 'should return error message' do
        expect(body['msg']).to    eq "bad argument: invalid_order_id"
        expect(body['status']).to eq 1001
      end
    end

    context 'when order_id is missing' do
      subject { client.order }
      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError, "missing keyword: order_id")
      end
    end
  end

  describe '#cancel_order', fcoin_auth: true, vcr: { cassette_name: 'orders/cancel_order_auth', record: :new_episodes } do
    context 'when input correct' do
      let(:response) { client.cancel_order(order_id: "nMEC_VrW0LYlP4iCcWzmdL50jFrvNWZoaQxvZSjeUSA=") }
      let(:body)     { JSON.parse(response.body) }

      it 'response data should be got' do
        expect(body['status']).to eq 0
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when input incorrect' do
      let(:response) { client.cancel_order(order_id: :invalid_order_id) }
      let(:body)     { JSON.parse(response.body) }

      it 'response data should be got' do
        expect(body['msg']).to    eq "bad argument: invalid_order_id"
        expect(body['status']).to eq 1001
      end

      it 'response status code is 200' do
        expect(response.status).to eq 400
      end
    end

    context 'when order_id is missing' do
      subject { client.cancel_order }
      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError, "missing keyword: order_id")
      end
    end
  end

  describe '#order_match_results(order_transaction)', fcoin_auth: true, vcr: { cassette_name: 'orders/order_match_results_auth', record: :new_episodes } do
    context 'when input correct' do
      let(:response)   { client.order_match_results(order_id: "kW3cRiXIGHG-cHNdterbFBaVRsYfNqfoMzbeHEQcqp4=") }
      let(:body)       { JSON.parse(response.body) }
      let(:first_data) { body['data'].first }

      it 'response data should be got' do
        expect(first_data['price']).to         eq "1000"
        expect(first_data['fill_fees']).to     eq "0.00010000000000000"
        expect(first_data['filled_amount']).to eq "0.00500000000000000"
        expect(first_data['side']).to          eq "buy"
        expect(first_data['type']).to          eq "limit"
        expect(first_data['created_at']).to    eq 1531734385085
        expect(body['status']).to              eq 0
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when input incorrect' do
      let(:response) { client.order_match_results(order_id: :invalid_order_id) }
      let(:body)     { JSON.parse(response.body) }

      it 'response data should be got' do
        expect(body['msg']).to    eq "bad argument: invalid_order_id"
        expect(body['status']).to eq  1001
      end

      it 'response status code is 200' do
        expect(response.status).to eq 400
      end
    end

    context 'when order_id is missing' do
      subject { client.order_match_results }
      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError, "missing keyword: order_id")
      end
    end
  end
end
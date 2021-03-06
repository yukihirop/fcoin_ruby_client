require 'spec_helper'

RSpec.describe Fcoin::Endpoint::Orders do
  let(:client) { Fcoin::Client.new }

  describe '#create_order_limit' do
    context 'when client is authorized', fcoin_auth: true do
      context 'when input correct', vcr: { cassette_name: 'orders/create_order_limit_auth', record: :new_episodes } do
        let(:body)  { client.create_order_limit(symbol: :ftusdt, side: :sell, price: 10, amount: 3) }

        it 'response data should be got' do
          # order_id
          expect(body['data']).to   eq "bBuPgVpi7CmX9bvNVVwWl7dUrW5E3LToYqhCKislqxI="
          expect(body['status']).to eq 0
        end
      end

      context 'when input incorrect', vcr: { cassette_name: 'orders/create_order_limit_auth_incorrect', record: :new_episodes } do
        context 'when symbol is not valid' do
          let(:body)  { client.create_order_limit(symbol: :ftft, side: :sell, price: 10, amount: 10) }

          it 'should return error message' do
            expect(body['msg']).to    eq "invalid symbol: ftft"
            expect(body['status']).to eq 1004
          end
        end

        context 'when side and type and amount is not valid' do
          subject { client.create_order_limit(symbol: :ethusdt, side: :invalid_side, price: 1000, amount: 0.0001) }
          it 'should be raise error' do
            expect { subject }.to raise_error(Fcoin::InvalidValueError, '{:side=>"side is invalid_side. side is not included in the [buy, sell]."}')
          end

          context 'when skip validation' , vcr: { cassette_name: 'orders/create_order_limit_auth_incorrect_skip_validation', record: :new_episodes } do
            let(:body) { subject }
            before { allow(client).to receive(:skip_validation).and_return(true) }

            it 'should return error message' do
              expect(body['msg']).to    eq "api key check fail : {\"status\":1090,\"msg\":\"Illegal API signature\"}"
              expect(body['status']).to eq 6005
            end
          end
        end
      end

      context 'when params is missing' do
        subject { client.create_order_limit }
        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError, "missing keywords: symbol, side, price, amount")
        end
      end
    end

    context 'when client is not authorized', vcr: { cassette_name: 'orders/create_order_limit_not_auth', record: :new_episodes } do
      let(:body)  { client.create_order_limit(symbol: :ethusdt, side: :sell, price: 1000, amount: 0.001) }
      
      it 'should return error message' do
        expect(body['msg']).to    eq "api key check fail : {\"status\":1020,\"msg\":\"api key not found : Fcoin API Public Key\"}"
        expect(body['status']).to eq 6005
      end
    end
  end

  xdescribe '#create_order_market' do
    context 'when client is authorized', fcoin_auth: true do
      context 'when input correct', vcr: { cassette_name: 'orders/create_order_market_auth', record: :new_episodes } do
        context 'when sell' do
          let(:body)  { client.create_order_market(symbol: :btcusdt, side: :sell, amount: 0.001) }

          it 'response data should be got' do
            pending
            # TODO: don't check the operation because I have not sufficient money.
          end
        end

        context 'when buy' do
          let(:body) { client.create_order_market(symbol: :ftusdt, side: :buy, total: 5) }

          it 'response data should be got' do
            pending
            # TODO: don't check the operation because I have not sufficient money.
          end
        end
      end
      # abridgement
    end
    # abridgement
  end

  describe '#order_list', fcoin_auth: true, vcr: { cassette_name: 'orders/order_list_auth', record: :new_episodes } do
    context 'when input correct' do
      let(:body)   { client.order_list(symbol: :ethusdt, states: :canceled, page_before: nil, page_after: nil, per_page: 20) }
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

      context 'when states is kind of String' do
        let(:body)   { client.order_list(symbol: :ethusdt, states: 'canceled', page_before: nil, page_after: nil, per_page: 20) }
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
      end
    end

    context 'when input incorrect' do
      let(:body)  { client.order_list(symbol: :ftft, states: :canceled) }

      it 'should return error message' do
        expect(body['msg']).to    eq "invalid symbol: ftft"
        expect(body['status']).to eq 1004
      end

      context 'when symbol is nil' do
        subject { client.order_list(symbol: nil, states: :canceled) }
        it 'should be raise error' do
          expect { subject }.to raise_error(Fcoin::InvalidValueError, '{:symbol=>"symbol is nil. symbol can\'t be blank"}')
        end

        context 'when skip validation', vcr: { cassette_name: 'orders/order_list_auth_skip_validation', record: :new_episodes } do
          let(:body) { subject }
          before { allow(client).to receive(:skip_validation).and_return(true) }


          it 'should return error message' do
            expect(body['msg']).to    eq "argument is not null: {0}"
            expect(body['status']).to eq 1003
          end
        end
      end

      context 'when states is not valid' do
        subject { client.order_list(symbol: :ethusdt, states: :invalid_states) }
        it 'should be raise error' do
          expect { subject }.to raise_error(Fcoin::InvalidValueError, '{:states=>"states is invalid_states. states is not included in the [submitted, partial_filled, canceled, partial_canceled, filled, pending_cancel]."}')
        end
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
      let(:body) { client.order(order_id: "L7rbALEIoI0ymo3uOXBF4gT4BlyTxgHhGoZjvptIv2U=") }

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
      let(:body) { client.order(order_id: 'invalid_order_id') }

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
      let(:body) { client.cancel_order(order_id: "nMEC_VrW0LYlP4iCcWzmdL50jFrvNWZoaQxvZSjeUSA=") }

      it 'response data should be got' do
        expect(body['status']).to eq 0
      end
    end

    context 'when input incorrect' do
      let(:body) { client.cancel_order(order_id: :invalid_order_id) }

      it 'response data should be got' do
        expect(body['msg']).to    eq "bad argument: invalid_order_id"
        expect(body['status']).to eq 1001
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
      let(:body)   { client.order_match_results(order_id: "kW3cRiXIGHG-cHNdterbFBaVRsYfNqfoMzbeHEQcqp4=") }
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
    end

    context 'when input incorrect' do
      let(:body) { client.order_match_results(order_id: :invalid_order_id) }

      it 'response data should be got' do
        expect(body['msg']).to    eq "bad argument: invalid_order_id"
        expect(body['status']).to eq  1001
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
require 'spec_helper'

RSpec.describe Fcoin::Endpoint::Market do
  let(:client) { Fcoin::Client.new }

  describe '#market_ticker', vcr: { cassette_name: 'market/ticker', record: :new_episodes } do
    context 'when symbol is missing' do
      subject { client.market_ticker }
      it 'should be raise error' do
        expect{ subject }.to raise_error(ArgumentError, "missing keyword: symbol")
      end
    end

    context 'when input correct' do
      let(:body) { client.market_ticker(symbol: :fteth) }
      
      it 'response data should be got' do
        expect(body['data']['ticker']['btcusdt_base_price_today']).to eq 256708.07246276314
        expect(body['data']['ticker']['btcusdt_base_vol_today']).to   eq 511357160.8024736
        expect(body['data']['ticker']['highest_price_today']).to      eq 0.00052632
        expect(body['data']['ticker']['latest_price']).to             eq 0.00047
        expect(body['data']['ticker']['lowest_price_today']).to       eq 0.0004507
        expect(body['data']['ticker']['max_buy_amount']).to           eq 127.86
        expect(body['data']['ticker']['max_buy_price']).to            eq 0.00046966
        expect(body['data']['ticker']['min_sell_amount']).to          eq 9940.53
        expect(body['data']['ticker']['min_sell_price']).to           eq 0.00046998
        expect(body['data']['ticker']['most_recent_trade_vol']).to    eq 15.0
        expect(body['data']['ticker']['trade_price_yesterday']).to    eq 0.00052476
        expect(body['data']['type']).to   eq 'ticker.fteth'
        expect(body['data']['seq']).to    eq 20030480
        expect(body['status']).to         eq 0
      end
    end

    context 'when input incorrect' do
      let(:body) { client.market_ticker(symbol: :ftft) }

      it 'should be return error' do
        expect(body['msg']).to    eq 'invalid symbol'
        expect(body['status']).to eq 40003
      end
    end
  end

  describe '#market_depth', vcr: { cassette_name: 'market/depth', record: :new_episodes } do
    context 'when symbol and level is missing' do
      subject { client.market_depth }
      it 'should be raise error' do
        expect { subject }.to raise_error(ArgumentError, "missing keywords: symbol, level")
      end
    end

    context 'when input correct' do
      let(:body) { client.market_depth(symbol: :fteth, level: :L20) }

      it 'response data should be got' do
        expect(body['data']['bids'][0]['amount']).to eq 336.46
        expect(body['data']['bids'][0]['price']).to  eq 0.00047153
        expect(body['data']['asks'][0]['amount']).to eq 1062.205609
        expect(body['data']['asks'][0]['price']).to  eq 0.00047185
        expect(body['data']['ts']).to                eq 1532156185014
        expect(body['data']['seq']).to               eq 20030698
        expect(body['data']['type']).to              eq 'depth.L20.fteth'
        expect(body['status']).to                    eq 0
      end
    end

    context 'when input incorrect' do
      subject { client.market_depth(symbol: :fteth, level: :invalid_level) }

      it 'should be raise error' do
        expect { subject }.to raise_error(Fcoin::InvalidValueError, '{:level=>"level is invalid_level. level is not included in the [L20, L100, full]."}')
      end

      context 'when validation skip' do
        let(:body) { subject }
        before { allow(client).to receive(:skip_validation).and_return(true) }

        it 'should return error message' do
          expect(body['msg']).to    eq "invalid depth-level"
          expect(body['status']).to eq 40003
        end
      end
    end
  end

  describe '#market_trades', vcr: { cassette_name: 'market/trades', record: :new_episodes } do
    context 'when symbol is missing' do
      subject { client.market_trades }
      it 'should be raise error' do
        expect { subject }.to raise_error(ArgumentError, "missing keyword: symbol")
      end
    end

    context 'when input correct' do
      let(:body)    { client.market_trades(symbol: :fteth) }
      let(:first_data)  { body['data'].first }

      it 'response data should be got' do
        expect(first_data['amount']).to eq 50.0
        expect(first_data['ts']).to     eq 1531572926666
        expect(first_data['id']).to     eq 17449441000
        expect(first_data['side']).to   eq 'sell'
        expect(first_data['price']).to  eq 0.00057727
        expect(body['status']).to       eq 0
      end
    end

    context 'when input incorrect' do
      let(:body) { client.market_trades(symbol: :ftft) }

      it 'should be return error' do
        expect(body['msg']).to    eq 'invalid symbol'
        expect(body['status']).to eq 40003
      end
    end
  end

  describe '#market_candles', vcr: { cassette_name: 'market/candles', record: :new_episodes } do
    context 'when resolution is missing' do
      subject { client.market_candles }
      it 'should be raise error' do
        expect { subject }.to raise_error(ArgumentError, "missing keywords: symbol, resolution")
      end
    end

    context 'when input correct' do
      let(:body)   { client.market_candles(symbol: :fteth, resolution: :MN) }
      let(:first_data) { body['data'].first }

      it 'response data should be got' do
        expect(first_data['open']).to      eq 0.000904
        expect(first_data['close']).to     eq 0.00056536
        expect(first_data['high']).to      eq 0.00093
        expect(first_data['quote_vol']).to eq 866076.2881899741
        expect(first_data['id']).to        eq 1530374400
        expect(first_data['count']).to     eq 3011075
        expect(first_data['low']).to       eq 0.00048948
        expect(first_data['seq']).to       eq 1749385600000
        expect(first_data['base_vol']).to  eq 1394688128.6132514
        expect(body['status']).to          eq 0
      end
    end

    context 'when input incorrect' do
      subject { client.market_candles(resolution: :invalid_resolution, symbol: :fteth) }
      it 'shoud be raise error' do
        expect { subject }.to raise_error(Fcoin::InvalidValueError, '{:resolution=>"resolution is invalid_resolution. resolution is not included in the [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN]."}')
      end

      context 'when skip validation' do
        let(:body) { subject }
        before { allow(client).to receive(:skip_validation).and_return(true) }

        it 'should return error message' do
          expect(body['msg']).to    eq "invalid period"
          expect(body['status']).to eq 40003
        end
      end
    end
  end
end

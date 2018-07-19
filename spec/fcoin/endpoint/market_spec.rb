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
      let(:response) { client.market_ticker(symbol: :fteth) }
      let(:body)     { JSON.parse(response.body) }
      
      it 'response data should be got' do
        expect(body['data']['ticker']).to eq [0.00058321, 701.68, 0.00058276, 3.9, 0.00058298, 5.0, 0.00057335, 0.00064789, 0.0005328, 218874435.2093026, 125152.76630129317]
        expect(body['data']['type']).to   eq 'ticker.fteth'
        expect(body['data']['seq']).to    eq 17433962
        expect(body['status']).to         eq 0
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when input incorrect' do
      let(:response) { client.market_ticker(symbol: :ftft) }
      let(:body)     { JSON.parse(response.body) }

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
      let(:response) { client.market_depth(symbol: :fteth, level: :L20) }
      let(:body)     { JSON.parse(response.body) }

      it 'response data should be got' do
        expect(body['data']['bids']).to eq [0.000577640,5.000000000,0.000577630,1952.350000000,0.000577540,55.000000000,0.000577450,3.500000000,0.000577340,70.000000000,0.000577250,3.900000000,0.000577240,12.370000000,0.000577040,3.270000000,0.000577030,23.380000000,0.000577010,3.050000000,0.000577000,1362.350000000,0.000576950,977.660000000,0.000576910,500.000000000,0.000576710,3.360000000,0.000576700,3.860000000,0.000576690,7592.700000000,0.000576570,1000.000000000,0.000576500,2485.640000000,0.000576490,159.580000000,0.000576480,3.090000000]
        expect(body['data']['asks']).to eq [0.000577650,1558.975699600,0.000578000,432.820000000,0.000578010,3.700000000,0.000578020,4.640000000,0.000578030,3.910000000,0.000578190,23.370000000,0.000578310,3.670000000,0.000578320,3.740000000,0.000578380,155.570000000,0.000578770,130.000000000,0.000578810,158.940000000,0.000578910,3.700000000,0.000578920,130.000000000,0.000579010,13.580000000,0.000579030,130.000000000,0.000579090,420.000000000,0.000579230,600.000000000,0.000579270,973.740000000,0.000579350,23.290000000,0.000579390,23.260000000]
        expect(body['data']['ts']).to   eq 1531570757013
        expect(body['data']['seq']).to  eq 17440636
        expect(body['data']['type']).to eq 'depth.L20.fteth'
        expect(body['status']).to       eq 0
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when input incorrect' do
      subject { client.market_depth(symbol: :fteth, level: :invalid_level) }

      it 'should be raise error' do
        expect { subject }.to raise_error(Fcoin::InvalidValueError, "Invalid value level: invalid_level.\nPlease input L20, L100 or full.")
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
      let(:response)    { client.market_trades(symbol: :fteth) }
      let(:body)        { JSON.parse(response.body) }
      let(:first_data)  { body['data'].first }

      it 'response data should be got' do
        expect(first_data['amount']).to eq 50.0
        expect(first_data['ts']).to     eq 1531572926666
        expect(first_data['id']).to     eq 17449441000
        expect(first_data['side']).to   eq 'sell'
        expect(first_data['price']).to  eq 0.00057727
        expect(body['status']).to       eq 0
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when input incorrect' do
      let(:response) { client.market_trades(symbol: :ftft) }
      let(:body)     { JSON.parse(response.body) }

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
      let(:response)   { client.market_candles(symbol: :fteth, resolution: :MN) }
      let(:body)       { JSON.parse(response.body) }
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

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when input incorrect' do
      subject { client.market_candles(resolution: :invalid_resolution, symbol: :fteth) }
      it 'shoud be raise error' do
        expect { subject }.to raise_error(Fcoin::InvalidValueError, "Invalid value resolution: invalid_resolution.\nPlease input M1, M3, M5, M15, M30, H1, H4, H6, D1, W1 or MN.")
      end
    end
  end
end

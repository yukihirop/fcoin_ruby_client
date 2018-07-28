require 'spec_helper'

RSpec.describe Fcoin::MarketValidator do
  let(:validator) { Fcoin::MarketValidator.new(params) }

  describe '#valid?' do
    subject { validator.valid? }

    context 'when market_depth' do
      context 'when success' do
        let(:params) { { level: :L20, method_name: :market_depth } }
        it { is_expected.to eq true }
      end

      context 'when failure' do
        let(:params) { { level: :invalid_level, method_name: :market_depth } }
        it { is_expected.to eq false }
      end
    end

    context 'when market_candles' do
      context 'when success' do
        let(:params) { { resolution: :M1, method_name: :market_candles} }
        it { is_expected.to eq true }
      end

      context 'when failure' do
        let(:params) { { resolution: :invalid_resolution, method_name: :market_candles} }
        it { is_expected.to eq false }
      end
    end
  end

  describe '#messages' do
    subject { validator.messages }

    context 'when market_depth' do
      context 'when success' do
        let(:params) { { level: :L20, method_name: :market_depth } }
        it { is_expected.to be_blank }
      end

      context 'when failure' do
        let(:params) { { level: :L40, method_name: :market_depth } }
        it { is_expected.to include({:level => "level is L40. level is not included in the [L20, L100, full]."}) }
      end
    end

    context 'when market_candles' do
      context 'when success' do
        let(:params) { { resolution: :M1, method_name: :market_candles} }
        it { is_expected.to be_blank }
      end

      context 'when failure' do
        let(:params) { { resolution: :invalid_resolution, method_name: :market_candles} }
        it { is_expected.to include({:resolution=>"resolution is invalid_resolution. resolution is not included in the [M1, M3, M5, M15, M30, H1, H4, H6, D1, W1, MN]."})}
      end
    end
  end
end
require 'spec_helper'

RSpec.describe Fcoin::Orders::CreateOrderMarketValidator do
  let(:validator) { described_class.new(params) }

  describe '#valid?' do
    subject { validator.valid? }

    context 'when success' do
      let(:params) { { symbol: :ethusdt, side: :sell, amount: 0.001 } }
      it { is_expected.to eq true }

      context 'when setting do not exist' do
        let(:params) { { symbol: :not_setting, side: :sell, amount: 0.001 } }
        it { is_expected.to eq true }
      end
    end

    context 'when failure' do
      let(:params) { { symbol: :ethusdt, side: :sell, amount: 0.0001 } }
      it { is_expected.to eq false }

      context 'when symbol do not exist' do
        let(:params) { { symbol: nil, side: :sell, amount: 0.0001 } }
        it { is_expected.to eq false }
      end

      context 'when do not adapted on-going order' do
        let(:params) { { symbol: :fiusdt, side: :sell, amount: 0.0001 } }
        it { is_expected.to eq false }
      end
    end
  end

  describe '#messages' do
    subject { validator.messages }

    context 'when valid' do
      let(:params) { { symbol: :ethusdt, side: :sell, price: 1000, amount: 0.001 } }
      it { is_expected.to be_blank }

      context 'when setting do not exist' do
        let(:params) { { symbol: :not_setting, side: :sell, price: 1000, amount: 0.001 } }
        it { is_expected.to be_blank }
      end
    end

    context 'when invalid' do
      let(:params) { { symbol: :ethusdt, side: :sell, price: 100000, amount: 0.0001 } }
      it { is_expected.to include({
        :amount => "amount is 0.0001. amount is not between 0.001 and 10000.",
        })
      }

      context 'when symbol do not exist' do
        let(:params) { { symbol: nil, side: :sell, price: 100000, amount: 0.0001 } }
        it { is_expected.to include({
          :symbol => "symbol is nil. symbol can't be blank",
          })
        }
      end

      context 'when do not adapted on-going order' do
        let(:params) { { symbol: :fiusdt, side: :sell, amount: 0.0001 } }
        it { is_expected.to include({
          :symbol => "symbol is fiusdt. This symbol board is not adapted on-going order.",
          })
        }
      end
    end
  end
end

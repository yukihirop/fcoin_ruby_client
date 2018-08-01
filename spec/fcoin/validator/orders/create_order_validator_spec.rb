require 'spec_helper'

RSpec.describe Fcoin::Orders::CreateOrderValidator do
  let(:validator) { described_class.new(params) }

  describe '#valid?' do
    subject { validator.valid? }

    context 'when failure' do
      context 'when type is invalid' do
        let(:params) { { symbol: :ethusdt, side: :sell, type: :invalid_type, price: 100000, amount: 0.0001 } }
        it { is_expected.to eq false }
      end

      context 'when symbol do not exist' do
        let(:params) { { symbol: nil, side: :sell, type: :limit,  price: 100000, amount: 0.0001 } }
        it { is_expected.to eq false }
      end
    end
  end

  describe '#message' do
    subject { validator.messages }

    context 'when failure' do
      context 'when type is invalid' do
        let(:params) { { symbol: :ethusdt, side: :sell, type: :invalid_type, price: 100000, amount: 0.0001 } }
        it { is_expected.to include({
          :type => "type is invalid_type. type is not included in the [limit, market].",
          })
        }
      end

      context 'when symbol do not exist' do
        let(:params) { { symbol: nil, side: :sell, type: :limit,  price: 100000, amount: 0.0001 } }
        it { is_expected.to include({
          :symbol => "symbol is nil. symbol can't be blank",
          })
        }
      end
    end
  end
end

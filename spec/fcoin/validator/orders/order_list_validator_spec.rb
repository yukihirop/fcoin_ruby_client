require 'spec_helper'

RSpec.describe Fcoin::Orders::OrderListValidator do
  let(:validator) { described_class.new(params) }

  describe '#valid?' do
    subject { validator.valid? }

    context 'when success' do
      let(:params) { { symbol: :ethusdt, states: :canceled, method_name: :order_list } }
      it { is_expected.to eq true }
    end

    context 'when failure' do
      let(:params) { { symbol: :ethusdt, states: :invalid_states, method_name: :order_list } }
      it { is_expected.to eq false }

      context 'when symbol do not exist' do
        let(:params) { { symbol: nil, states: :canceled, method_name: :order_list } }
        it { is_expected.to eq false }
      end
    end
  end

  describe '#messages' do
    subject { validator.messages }
    
    context 'when valid' do
      let(:params) { { symbol: :ethusdt, states: :canceled, method_name: :order_list } }
      it { is_expected.to be_blank }
    end

    context 'when invalid' do
      let(:params) { { symbol: :ethusdt, states: :invalid_states, method_name: :order_list } }
      it { is_expected.to include({
        :states => "states is invalid_states. states is not included in the [submitted, partial_filled, canceled, partial_canceled, filled, pending_cancel].",
        })
      }

      context 'when symbol do not exist' do
        let(:params) { { symbol: nil, states: :canceled, method_name: :order_list } }
        it { is_expected.to include({
          :symbol => "symbol is nil. symbol can't be blank",
          })
        }
      end
    end
  end
end

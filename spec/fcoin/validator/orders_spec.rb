require 'spec_helper'

RSpec.describe Fcoin::OrdersValidator do
  let(:validator) { Fcoin::OrdersValidator.new(params) }

  describe '#valid?' do
    subject { validator.valid? }

    context 'when create_order' do
      context 'when success' do
        let(:params) { { symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
        it { is_expected.to eq  true }
      end

      context 'when failure' do
        let(:params) { { method_name: :create_order } }
        it { is_expected.to eq false }
      end
    end

    context 'when order_list' do
      context 'when success' do
        let(:params) { { symbol: :ethusdt, states: :canceled, method_name: :order_list } }
        it { is_expected.to eq true }
      end

      context 'when failure' do
        let(:params) { { method_name: :order_list } }
        it { is_expected.to eq false }
      end
    end
  end

  describe '#messages' do
    subject { validator.messages }

    context 'when create_order' do
      context 'when success' do
        let(:params) { { symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
        it { is_expected.to be_blank }
      end

      context 'when failure' do
        context 'when symbol is nil' do
          let(:params) { { method_name: :create_order } }
          it { is_expected.to include({
            :side => "side is nil. side is not included in the [buy, sell].",
            :symbol => "symbol is nil. symbol can't be blank",
            :type => "type is nil. type is not included in the [limit, market]."
          }) }
        end

        context 'when symbol is exist' do
          let(:params) { { symbol: :ethusdt, method_name: :create_order } }
          it { is_expected.to include({
            :amount => "amount is nil. amount is not between 0.001 and 10000.",
            :price => "price is nil. price is not between 1 and 10000.",
            :side => "side is nil. side is not included in the [buy, sell].",
            :type => "type is nil. type is not included in the [limit, market]."
          }) }
        end
      end
    end

    context 'when order_list' do
      context 'when success' do
        let(:params) { { symbol: :ethusdt, states: :canceled, method_name: :order_list } }
        it { is_expected.to be_blank }
      end

      context 'when failure' do
        context 'when symbol is nil' do
          let(:params) { { method_name: :order_list } }
          it { is_expected.to include({
            :symbol => "symbol is nil. symbol can't be blank"
          }) }
        end

        context 'when symbol is exist' do
          let(:params) { { symbol: :ethusdt, method_name: :order_list } }
          it { is_expected.to include({
            :states => "states is nil. states is not included in the [submitted, partial_filled, canceled, partial_canceled, filled, pending_cancel]."
          }) }
        end
      end
    end
  end
end
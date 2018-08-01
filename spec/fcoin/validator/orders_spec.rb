require 'spec_helper'

RSpec.describe Fcoin::OrdersValidator do
  let(:validator) { Fcoin::OrdersValidator.new(params) }

  describe '#valid?' do
    subject { validator.valid? }

    context 'when create_order' do
      context 'when success' do
        context 'when limit' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
          it { is_expected.to eq true }

          context 'when symbol do not exist' do
            let(:params) { { symbol: :no_setting, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
            it { is_expected.to eq true }
          end
        end

        context 'when market' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :market, amount: 0.001, method_name: :create_order } }
          it { is_expected.to eq true }

          context 'when symbol do not exist' do
            let(:params) { { symbol: :no_setting, side: :sell, type: :market, amount: 0.001, method_name: :create_order } }
            it { is_expected.to eq true }
          end
        end
      end

      context 'when failure' do
        context 'when limit' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :limit, price: 100000, amount: 0.00001, method_name: :create_order } }
          it { is_expected.to eq false }

          context 'when symbol is blank' do
            let(:params) { { symbol: nil, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
            
            it { is_expected.to eq false }
          end
        end

        context 'when market' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :market, amount: 0.00001, method_name: :create_order } }
          it { is_expected.to eq false }

          context 'when symbol is blank' do
            let(:params) { { symbol: nil, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
            it { is_expected.to eq false }
          end
        end
      end
    end

    context 'when order_list' do
      context 'when success' do
        let(:params) { { symbol: :ethusdt, states: :canceled, method_name: :order_list } }
        it { is_expected.to eq true }
      end

      context 'when failure' do
        let(:params) { { symbol: nil, states: :canceled, method_name: :order_list } }
        it { is_expected.to eq false }
      end
    end
  end

  describe '#messages' do
    subject { validator.messages }

    context 'when create_order' do
      context 'when success' do
        context 'when limit' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
          it { is_expected.to be_blank }

          context 'when symbol do not exist' do
            let(:params) { { symbol: :no_setting, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
            it { is_expected.to be_blank }
          end
        end

        context 'when market' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :market, amount: 0.001, method_name: :create_order } }
          it { is_expected.to be_blank }

          context 'when symbol do not exist' do
            let(:params) { { symbol: :no_setting, side: :sell, type: :market, amount: 0.001, method_name: :create_order } }
            it { is_expected.to be_blank }
          end
        end
      end

      context 'when failure' do
        context 'when limit' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :limit, price: 100000, amount: 0.00001, method_name: :create_order } }
          it { is_expected.to include({
            :amount => "amount is 1.0e-05. amount is not between 0.001 and 10000.",
            :price => "price is 100000. price is not between 1 and 10000.",
            })
          }

          context 'when symbol is blank' do
            let(:params) { { symbol: nil, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
            
            it { is_expected.to include({
              :symbol => "symbol is nil. symbol can't be blank",
              }) }
          end
        end

        context 'when market' do
          let(:params) { { symbol: :ethusdt, side: :sell, type: :market, amount: 0.00001, method_name: :create_order } }
          it { is_expected.to include({
            :amount => "amount is 1.0e-05. amount is not between 0.001 and 10000.",
            })
          }

          context 'when symbol is blank' do
            let(:params) { { symbol: nil, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
            it { is_expected.to include({
              :symbol => "symbol is nil. symbol can't be blank",
              }) }
          end
        end
      end
    end

    context 'when order_list' do
      context 'when success' do
        let(:params) { { symbol: :ethusdt, states: :canceled, method_name: :order_list } }
        it { is_expected.to be_blank }
      end

      context 'when failure' do
        context 'when symbol is blank' do
          let(:params) { { symbol: nil, side: :sell, type: :limit, price: 1000, amount: 0.001, method_name: :create_order } }
          it { is_expected.to include({
            :symbol => "symbol is nil. symbol can't be blank",
            })
          }
        end
      end
    end
  end
end
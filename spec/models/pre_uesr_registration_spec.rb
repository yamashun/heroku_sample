require 'rails_helper'

RSpec.describe PreUserRegistration, type: :model do
  describe '#validates' do
    subject { pre_user_registration.valid? }

    context 'invalid' do
      let(:pre_user_registration) do
        build :pre_user_registration,
              mail_address: 'invalid'
      end

      it { is_expected.to be false }
    end

    context 'valid' do
      let(:pre_user_registration) do
        build :pre_user_registration,
              mail_address: 'xxxx@co.jp'
      end

      it { is_expected.to be true }
    end
  end
end

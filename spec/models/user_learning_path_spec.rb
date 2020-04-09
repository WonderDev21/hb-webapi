require 'rails_helper'

RSpec.describe UserLearningPath, type: :model do
  describe 'before_validation callbacks' do
    describe 'ensure_funds_with_payment' do
      let(:user) { create(:user) }
      let(:learning_path) { create(:learning_path) }
      let(:payment_profile) { create(:payment_profile, user: user) }
      let(:user_learning_path) { build(:user_learning_path, user: user, learning_path: learning_path, funding_source: 'payment') }
      let(:charge_service) { instance_double('ChargeService') }

      it 'marks user as valid when the associated payment_profile is valid' do
        charge = create(:charge, status: 'paid', chargeable: user_learning_path, payment_profile: payment_profile)
        expect(ChargeService).to receive(:new) { charge_service }
        expect(charge_service).to receive(:run) { charge }

        expect(user_learning_path).to be_valid
      end

      it 'marks user as invalid when the associated payment_profile is invalid' do
        charge = create(:charge, status: 'failed', chargeable: user_learning_path, payment_profile: payment_profile)
        expect(ChargeService).to receive(:new) { charge_service }
        expect(charge_service).to receive(:run) { charge }

        expect(user_learning_path).to_not be_valid
      end
    end
  end
end

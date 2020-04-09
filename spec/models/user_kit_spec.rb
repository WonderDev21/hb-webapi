require 'rails_helper'

RSpec.describe UserKit, type: :model do
  describe 'before_validation callbacks' do
    describe 'ensure_funds_with_payment' do
      let(:user) { create(:user) }
      let(:kit) { create(:kit) }
      let(:payment_profile) { create(:payment_profile, user: user) }
      let(:user_kit) { build(:user_kit, user: user, kit: kit, funding_source: 'payment') }
      let(:charge_service) { instance_double('ChargeService') }

      it 'marks user as valid when the associated payment_profile is valid' do
        charge = create(:charge, status: 'paid', chargeable: user_kit, payment_profile: payment_profile)
        expect(ChargeService).to receive(:new) { charge_service }
        expect(charge_service).to receive(:run) { charge }

        expect(user_kit).to be_valid
      end

      it 'marks user as invalid when the associated payment_profile is invalid' do
        charge = create(:charge, status: 'failed', chargeable: user_kit, payment_profile: payment_profile)
        expect(ChargeService).to receive(:new) { charge_service }
        expect(charge_service).to receive(:run) { charge }

        expect(user_kit).to_not be_valid
      end
    end
  end
end

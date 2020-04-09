require 'rails_helper'

RSpec.describe ChargeService, type: :model do
  describe '#run' do
    let(:user) { create(:user) }
    let(:payment_profile) { create(:payment_profile, user: user) }
    let(:chargeable) { create(:kit) }

    it 'creates a new charge with status `paid` when Stripe response is successful' do
      response = { paid: true, id: 'ch_1234567890', status: 'success' }
      expect(Stripe::Charge).to receive(:create) { response }
      charge = ChargeService.new(payment_profile, chargeable).run

      expect(charge).to be_paid
    end

    it 'creates a new charge with status `failed` when Stripe response is not successful' do
      response = { paid: false, id: 'ch_1234567890', status: 'failed' }
      expect(Stripe::Charge).to receive(:create) { response }
      charge = ChargeService.new(payment_profile, chargeable).run

      expect(charge).to be_failed
    end

    it 'creates a new stripe customer using `stripe_token` when the user does not have a customer_id' do
      response = { paid: true, id: 'ch_1234567890', status: 'success' }
      expect(Stripe::Customer).to receive(:create) { double('Stripe::Customer', id: '1') }
      expect(Stripe::Charge).to receive(:create) { response }
      payment_profile = create(:payment_profile, user: user, external_payment_info: { 'stripe_token' => 'token' })
      charge = ChargeService.new(payment_profile, chargeable).run

      expect(charge).to be_paid
      expect(payment_profile.reload.external_payment_info).to eq('stripe_customer_id' => '1')
    end
  end
end

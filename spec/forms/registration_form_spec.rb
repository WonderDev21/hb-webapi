require 'rails_helper'

RSpec.describe RegistrationForm, type: :model do
  let(:registration_form) { RegistrationForm.new(User.new) }

  describe 'with valid attributes' do
    before(:each) do
      registration_form.submit(attributes_for(:user))
      registration_form.save
    end

    describe '#save' do
      it 'persist to associated user' do
        expect(registration_form).to be_persisted
      end
    end

    describe '#model' do
      it 'returns to persisted user' do
        expect(registration_form.model).to be_persisted
      end
    end
  end

  describe 'with invalid attributes' do
    before(:each) do
      registration_form.submit(attributes_for(:invalid_user))
      registration_form.save
    end

    describe '#save' do
      it 'does not persist to associated user' do
        expect(registration_form).to_not be_persisted
      end
    end

    describe '#model' do
      it 'returns to unpersisted user' do
        expect(registration_form.model).to_not be_persisted
        expect(registration_form.errors).to_not be_empty
      end
    end
  end
end

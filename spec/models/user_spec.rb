require 'rails_helper'

RSpec.describe User, type: :model do
  describe '`password_confirmation` validation' do
    describe 'on new users' do
      let(:user) { build(:user) }

      it 'mark user as invalid if `password` is set but `password_confirmation` is not' do
        user.password = 'password2$'
        expect(user).to be_invalid
      end

      it 'mark user as valid if `password` is set and `password_confirmation` is equal' do
        user.password = 'password2$'
        user.password_confirmation = 'password2$'
        expect(user).to be_valid
      end
    end

    describe 'on existing users' do
      let(:user) { create(:user) }

      it 'mark user as invalid if `password` is set but `password_confirmation` is not' do
        user.password = 'password2$'
        expect(user).to be_invalid
      end

      it 'mark user as valid if `password` is set and `password_confirmation` is equal' do
        user.password = 'password2$'
        user.password_confirmation = 'password2$'
        expect(user).to be_valid
      end
    end
  end
end

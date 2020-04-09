require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'reset_password_instructions' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.reset_password_instructions(user, 'abcdef') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Reset password instructions')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['no-reply@heartbit.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Change my password')
    end
  end
end

require 'rails_helper'

describe 'Passwords API' do
  describe 'POST /passwords' do
    let(:user) { create(:user) }

    describe 'when a valid email is passed' do
      it 'creates a reset_password_token and send it by email' do
        expect do
          post_json '/passwords', data: { type: 'password', attributes: { email: user.email } }
        end.to change { ActionMailer::Base.deliveries.count }.by(1)

        expect(response.status).to eq(204)
        expect(user.reload.reset_password_token).to_not be_nil
      end
    end

    describe 'when an invalid email is passed' do
      it 'does not send an email' do
        expect do
          post_json '/passwords', data: { type: 'password', attributes: { email: 'unknown-email@heartbit.com' } }
        end.to_not change { ActionMailer::Base.deliveries.count }

        expect(response.status).to eq(204)
      end
    end
  end

  describe 'PATCH /passwords' do
    let(:user) { create(:user, registration_state: 'onboarding_completed') }

    describe 'when a valid reset_password_token is passed' do
      before do
        @raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
        user.reset_password_token = hashed_token
        user.reset_password_sent_at = Time.now.utc
        user.save(validate: false)
      end

      it 'updates the user password' do
        params = {
          data: {
            type: 'password',
            attributes: {
              password: 'newpassword1$',
              password_confirmation: 'newpassword1$',
              reset_password_token: @raw_token
            }
          }
        }
        patch_json '/passwords', params

        expect(response.status).to eq(200)
        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['attributes']['email']).to eq(user.email)
        expect(user.reload.valid_password?('newpassword1$')).to be(true)
      end
    end

    describe 'when a invalid reset_password_token is used' do
      it 'does not update user password' do
        params = {
          data: {
            type: 'password',
            attributes: {
              password: 'newpassword1$',
              password_confirmation: 'newpassword1$',
              reset_password_token: 'badtoken'
            }
          }
        }
        patch_json '/passwords', params

        expect(response.status).to eq(422)
        expect(json_response['errors'][0]['source']['pointer']).to eq('/data/attributes/reset_password_token')
        expect(json_response['errors'][0]['detail']).to eq('is invalid')
        expect(user.reload.valid_password?('anewpass1$')).to be(false)
      end
    end

    describe 'when valid current password is used' do
      let(:user) { create(:user, registration_state: 'onboarding_completed', password: 'password1$') }

      it 'updates the user password' do
        params = {
          data: {
            type: 'password',
            attributes: {
              password: 'newpassword1$',
              password_confirmation: 'newpassword1$',
              current_password: 'password1$'
            }
          }
        }
        patch_json '/passwords', params, auth_headers(user)

        expect(response.status).to eq(200)
        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['attributes']['email']).to eq(user.email)
        expect(user.reload.valid_password?('newpassword1$')).to be(true)
      end
    end

    describe 'when a invalid current password is used' do
      let(:user) { create(:user, registration_state: 'onboarding_completed', password: 'password1$') }

      it 'does not update user password' do
        params = {
          data: {
            type: 'password',
            attributes: {
              password: 'newpassword1$',
              password_confirmation: 'newpassword1$',
              current_password: 'badpassword'
            }
          }
        }
        patch_json '/passwords', params, auth_headers(user)

        expect(response.status).to eq(422)
        expect(json_response['errors'][0]['source']['pointer']).to eq('/data/attributes/current_password')
        expect(json_response['errors'][0]['detail']).to eq('is invalid')
        expect(user.reload.valid_password?('newpassword1$')).to be(false)
      end
    end
  end
end

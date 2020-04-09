require 'rails_helper'

describe 'Tokens API' do
  describe 'POST /token' do
    let(:user) { create(:user) }

    it 'create new token for the user with correct credentials' do
      post_json '/token', data: { type: 'tokens', attributes: { email: user.email, password: user.password } }

      expect(response.status).to eq(201)
      expect(response.headers['Authorization']).to_not be_nil
      expect(json_response['data']['attributes']['token']).to_not be_nil
    end

    it 'does not create a new token for the user with wrong credentials' do
      post_json '/token', data: { type: 'tokens', attributes: { email: user.email, password: 'badpass' } }

      expect(response.status).to eq(401)
      expect(response.headers['Authorization']).to be_nil
      expect(json_response['errors'][0]['code']).to eq('unauthorized')
    end
  end

  describe 'DELETE /token' do
    let(:user) { create(:user) }

    it 'deletes an existing token' do
      expect do
        delete_json '/token', {}, auth_headers(user)
      end.to change { user.reload.jti }

      expect(response.status).to eq(204)
    end
  end
end

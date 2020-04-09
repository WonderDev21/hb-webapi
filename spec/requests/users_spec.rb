require 'rails_helper'

describe 'Users API' do
  describe 'GET /users/{id}' do
    let(:user) { create(:user, registration_state: 'onboarding_completed') }

    it 'list a single user information' do
      get_json "/users/#{user.id}", auth_headers(user)

      expect(response.status).to eq(200)
      expect(json_response['data']['type']).to eq('user')
      expect(json_response['data']['attributes']['first_name']).to eq(user.first_name)
    end
  end

  describe 'POST /users' do
    it 'create new users Student with valid attributes' do
      user_attributes = attributes_for(:user)
      post_json '/users', data: { type: 'users', attributes: user_attributes }

      expect(response.status).to eq(201)
      expect(json_response['data']['type']).to eq('user')
      expect(json_response['data']['attributes']['first_name']).to eq(user_attributes[:first_name])
      expect(json_response['data']['attributes']['role']).to eq('Student')
      expect(json_response['data']['attributes']['institution']).to eq(nil)
    end

    it 'create new users Teacher with valid attributes' do
      params = {
        data: {
          type: 'users',
          attributes: {
            email: 'john.doe.teacher@worldtechmakers.com',
            first_name: 'Johnatan',
            last_name: 'Doe',
            age: 25,
            city: 'Denver',
            terms_accepted: true,
            password: 'password1$',
            password_confirmation: 'password1$',
            role: 'Teacher',
            institution: 'Heartbit'
          }
        }
      }
      post_json '/users', params

      expect(response.status).to eq(201)
      expect(json_response['data']['type']).to eq('user')
      expect(json_response['data']['attributes']['first_name']).to eq('Johnatan')
      expect(json_response['data']['attributes']['role']).to eq('Teacher')
      expect(json_response['data']['attributes']['institution']).to eq('Heartbit')
    end

    it 'does not create new users with missing attributes' do
      user_attributes = attributes_for(:user)
      user_attributes.delete(:first_name)

      post_json '/users', data: { type: 'users', attributes: user_attributes }

      expect(response.status).to eq(422)
      expect(json_response['errors'][0]['source']['pointer']).to eq('/data/attributes/first_name')
      expect(json_response['errors'][0]['detail']).to eq("can't be blank")
    end
  end

  describe 'PATCH /users/{id}' do
    describe 'when user is on "language_pending" state' do
      let(:user) { create(:user, registration_state: 'language_pending') }
      let(:language) { create(:language) }

      it 'update an existing user with valid attributes' do
        params = {
          data: {
            type: 'users',
            attributes: {},
            relationships: {
              language: {
                data: {
                  id: language.id,
                  type: 'language'
                }
              }
            }
          }
        }
        patch_json '/users/self', params, auth_headers(user)

        expect(response.status).to eq(200)
        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['relationships']['language']['data']['id']).to eq(language.id.to_s)
        expect(json_response['data']['attributes']['registration_state']).to eq('onboarding_completed')
      end
    end

    describe 'when user is on "onboarding_completed" state' do
      let(:user) { create(:user, registration_state: 'onboarding_completed') }

      it 'update an existing user with valid attributes' do
        patch_json '/users/self', { data: { type: 'users', attributes: { first_name: 'Joanna' } } }, auth_headers(user)

        expect(response.status).to eq(200)
        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['attributes']['first_name']).to eq('Joanna')
      end
    end
  end
end

require 'rails_helper'
require 'stripe_mock'

describe 'User Kits API' do
  describe 'GET /user_learning_paths' do
    let(:stripe_helper) { StripeMock.create_test_helper }
    let(:user) { create(:user) }
    let(:learning_path) { create(:learning_path) }
    let(:payment_info) { { 'stripe_token' => stripe_helper.generate_card_token } }

    before { StripeMock.start }
    after { StripeMock.stop }

    it 'show all user learning paths associated to the user' do
      create(:payment_profile, user: user, external_payment_info: payment_info)
      create(:user_learning_path, user: user, learning_path: learning_path)

      get_json '/user_learning_paths', auth_headers(user)

      expect(response.status).to eq(200)
      expect(json_response['data'][0]['type']).to eq('user_learning_path')
      expect(json_response['data'][0]['attributes']['funding_source']).to eq('payment')
      expect(json_response['data'][0]['relationships']['learning_path']['data']['type']).to eq('learning_path')
      expect(json_response['data'][0]['relationships']['learning_path']['data']['id']).to eq(learning_path.id.to_s)
      expect(json_response['included'][0]['attributes']['title']).to eq(learning_path.title)
    end
  end

  describe 'POST /user_learning_paths' do
    describe 'when a payment is used to buy a learning path' do
      let(:stripe_helper) { StripeMock.create_test_helper }
      let(:user) { create(:user) }
      let(:learning_path) { create(:learning_path) }
      let(:payment_info) { { 'stripe_token' => stripe_helper.generate_card_token } }

      before { StripeMock.start }
      after { StripeMock.stop }

      it 'creates a new User Learning Path when payment is successful' do
        create(:payment_profile, user: user, external_payment_info: payment_info)

        params = {
          data: {
            type: 'user_learning_path',
            attributes: {
              funding_source: 'payment'
            },
            relationships: {
              learning_path: {
                data: {
                  type: 'learning_path',
                  id: learning_path.id.to_s
                }
              }
            }
          }
        }
        post_json '/user_learning_paths', params, auth_headers(user)

        expect(response.status).to eq(201)
        expect(json_response['data']['type']).to eq('user_learning_path')
        expect(json_response['data']['attributes']['funding_source']).to eq('payment')
        expect(json_response['data']['relationships']['learning_path']['data']['type']).to eq('learning_path')
        expect(json_response['data']['relationships']['learning_path']['data']['id']).to eq(learning_path.id.to_s)
      end

      it 'does not create a new User Learning Path when payment fails' do
        create(:payment_profile, user: user, external_payment_info: payment_info)
        StripeMock.prepare_card_error(:card_declined)

        params = {
          data: {
            type: 'user_learning_path',
            attributes: {
              funding_source: 'payment'
            },
            relationships: {
              learning_path: {
                data: {
                  type: 'learning_path',
                  id: learning_path.id.to_s
                }
              }
            }
          }
        }

        post_json '/user_learning_paths', params, auth_headers(user)

        expect(response.status).to eq(422)
        expect(json_response['errors'][0]['source']['pointer']).to eq('/data/attributes/funding_source')
        expect(json_response['errors'][0]['detail']).to eq('failed during charge')
      end
    end
  end
end

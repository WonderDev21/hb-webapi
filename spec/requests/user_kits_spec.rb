require 'rails_helper'
require 'stripe_mock'

describe 'User Kits API' do
  describe 'POST /user_kits' do
    describe 'when a payment is used to buy a kit' do
      let(:stripe_helper) { StripeMock.create_test_helper }
      let(:user) { create(:user) }
      let(:kit) { create(:kit) }
      let(:payment_info) { { 'stripe_token' => stripe_helper.generate_card_token } }

      before { StripeMock.start }
      after { StripeMock.stop }

      it 'creates a new User Kit when payment is successful' do
        create(:payment_profile, user: user, external_payment_info: payment_info)

        params = {
          data: {
            type: 'user_kit',
            attributes: {
              funding_source: 'payment'
            },
            relationships: {
              kit: {
                data: {
                  type: 'kit',
                  id: kit.id.to_s
                }
              }
            }
          }
        }
        post_json '/user_kits', params, auth_headers(user)

        expect(response.status).to eq(201)
        expect(json_response['data']['type']).to eq('user_kit')
        expect(json_response['data']['attributes']['funding_source']).to eq('payment')
        expect(json_response['data']['relationships']['kit']['data']['type']).to eq('kit')
        expect(json_response['data']['relationships']['kit']['data']['id']).to eq(kit.id.to_s)
      end

      it 'does not create a new User Kit when payment fails' do
        create(:payment_profile, user: user, external_payment_info: payment_info)
        StripeMock.prepare_card_error(:card_declined)

        params = {
          data: {
            type: 'user_kit',
            attributes: {
              funding_source: 'payment'
            },
            relationships: {
              kit: {
                data: {
                  type: 'kit',
                  id: kit.id.to_s
                }
              }
            }
          }
        }

        post_json '/user_kits', params, auth_headers(user)

        expect(response.status).to eq(422)
        expect(json_response['errors'][0]['source']['pointer']).to eq('/data/attributes/funding_source')
        expect(json_response['errors'][0]['detail']).to eq('failed during charge')
      end
    end
  end
end

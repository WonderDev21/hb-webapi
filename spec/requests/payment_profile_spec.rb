require 'rails_helper'

describe 'GET /payment_profile' do
  let(:user) { create(:user) }
  let!(:payment_profile) { create(:payment_profile, user: user) }

  it 'returns the user payment profile' do
    get_json '/payment_profile', auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data']['type']).to eq('payment_profile')
    expect(json_response['data']['attributes']['brand']).to eq('Visa')
  end
end

describe 'PUT /payment_profile' do
  let(:user) { create(:user) }

  it 'create or update a payment profile for the user' do
    params = {
      data: {
        type: 'payment_profile',
        attributes: {
          external_payment_info: {
            'stripe_token': 'token_FX2mrFpqfmNeml',
            'stripe_card': 'card_1F1yhI2eZvKYlo2C00o6u8pH'
          },
          last4: 1234,
          brand: 'Visa'
        }
      }
    }
    put_json '/payment_profile', params, auth_headers(user)

    expect(response.status).to eq(201)
    expect(json_response['data']['type']).to eq('payment_profile')
    expect(json_response['data']['attributes']['brand']).to eq('Visa')

    payment_profile = PaymentProfile.find(json_response['data']['id'])
    expect(payment_profile.external_payment_info['stripe_token']).to be_present
    expect(payment_profile.external_payment_info['stripe_card']).to be_present
  end
end

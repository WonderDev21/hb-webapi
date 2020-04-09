require 'rails_helper'

describe 'GET /languages' do
  let!(:language) { create(:language) }
  let(:user) { create(:user) }

  it 'shows all available languages' do
    get_json '/languages', auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data'][0]['type']).to eq('language')
    expect(json_response['data'][0]['attributes']['name']).to eq('english')
    expect(json_response['data'][0]['attributes']['image_url']).to eq('https://heartbit.amazonaws.com/languages/english.png')
  end
end

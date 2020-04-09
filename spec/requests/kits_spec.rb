require 'rails_helper'

describe 'GET /kits' do
  let!(:kit) { create(:kit) }
  let(:user) { create(:user) }

  it 'shows all available kits' do
    get_json '/kits', auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data'][0]['type']).to eq('kit')
    expect(json_response['data'][0]['attributes']['name']).to eq('Emotion Tech')
    expect(json_response['data'][0]['attributes']['image_url']).to eq('https://heartbit.amazonaws.com/kits/emotion-tech.png')
  end

  it 'shows the kit by id' do
    get_json '/kits/' + kit.id.to_s, auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data']['type']).to eq('kit')
    expect(json_response['data']['attributes']['name']).to eq('Emotion Tech')
    expect(json_response['data']['attributes']['price_in_cents']).to eq(1990)
    expect(json_response['data']['attributes']['image_url']).to eq('https://heartbit.amazonaws.com/kits/emotion-tech.png')
  end
end

describe 'POST /kits' do
  let(:user) { create(:user) }

  it 'creates a kit' do
    params = {
      data: {
        type: 'kit',
        attributes: {
          name: 'Fashion Tech',
          image_url: 'https://heartbit.amazonaws.com/kits/fashion-tech.png',
          industry: 'Fashion Tech',
          difficulty: 3,
          age: 8,
          description: 'This is a short description of what is this kit about',
          video_url: 'https://heartbit.amazonaws.com/kits/fashion-tech.mp4',
          published: true,
          background: '00FF00',
          price_in_cents: 1990
        }
      }
    }
    post_json '/kits', params, auth_headers(user)

    expect(response.status).to eq(201)
    expect(json_response['data']['type']).to eq('kit')
    expect(json_response['data']['attributes']['name']).to eq('Fashion Tech')
    expect(json_response['data']['attributes']['image_url']).to eq('https://heartbit.amazonaws.com/kits/fashion-tech.png')
  end
end

describe 'PATCH /kits' do
  let!(:kit) { create(:kit) }
  let(:user) { create(:user) }

  it 'update a kit by id' do
    params = {
      data: {
        type: 'kit',
        attributes: {
          name: 'Fashion Tech',
          industry: 'Fashion Tech'
        }
      }
    }
    patch_json '/kits/' + kit.id.to_s, params, auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data']['type']).to eq('kit')
    expect(json_response['data']['attributes']['name']).to eq('Fashion Tech')
    expect(json_response['data']['attributes']['industry']).to eq('Fashion Tech')
  end
end

describe 'DELETE /kits' do
  let!(:kit) { create(:kit) }
  let(:user) { create(:user) }

  it 'delete an existing kit' do
    delete_json '/kits/' + kit.id.to_s, auth_headers(user)

    expect(response.status).to eq(204)
  end
end

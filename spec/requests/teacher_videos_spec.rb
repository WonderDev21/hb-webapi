require 'rails_helper'

describe 'GET /teacher_videos' do
  let!(:teacher_video) { create(:teacher_video) }
  let(:user) { create(:user) }

  it 'shows all available videos for teachers' do
    get_json '/teacher_videos', auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data'][0]['type']).to eq('teacher_video')
    expect(json_response['data'][0]['attributes']['name']).to eq('Getting Started')
  end
end

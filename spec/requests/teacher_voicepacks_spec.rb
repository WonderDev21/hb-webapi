require 'rails_helper'

describe 'GET /teacher_voicepacks' do
  let!(:teacher_voicepack) { create(:teacher_voicepack) }
  let(:user) { create(:user) }

  it 'shows all available programs for teachers' do
    get_json '/teacher_voicepacks', auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data'][0]['type']).to eq('teacher_voicepack')
    expect(json_response['data'][0]['attributes']['name']).to eq('Foundations')
  end
end

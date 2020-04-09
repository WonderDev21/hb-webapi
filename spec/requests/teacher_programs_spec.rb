require 'rails_helper'

describe 'GET /teacher_programs' do
  let!(:teacher_program) { create(:teacher_program) }
  let(:user) { create(:user) }

  it 'shows all available programs for teachers' do
    get_json '/teacher_programs', auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data'][0]['type']).to eq('teacher_program')
    expect(json_response['data'][0]['attributes']['name']).to eq('First Year Teacher')
  end
end

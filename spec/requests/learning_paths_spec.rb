require 'rails_helper'
describe 'GET /learning_paths' do
  let!(:learning_path) { create(:learning_path) }
  let(:markdown_description) { MarkdownRenderer.new.render(learning_path.description) }
  let(:user) { create(:user) }

  it 'shows all available learning paths' do
    get_json '/learning_paths', auth_headers(user)

    expect(response.status).to eq(200)
    expect(json_response['data'][0]['type']).to eq('learning_path')
    expect(json_response['data'][0]['attributes']['title']).to eq('Introduction to STEAM')
    expect(json_response['data'][0]['attributes']['description']).to eq(markdown_description)
  end
end

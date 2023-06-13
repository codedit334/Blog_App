require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns http success and renders the index template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns http success and renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end

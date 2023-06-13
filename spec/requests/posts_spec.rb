require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    let(:user) { FactoryBot.create(:user) }

    before do
      FactoryBot.create_list(:post, 3, author: user)
    end

    it "returns http success and renders the index template" do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, author: user) }

    before do
      FactoryBot.create_list(:comment, 3, post: post)
    end

    it "returns http success and renders the show template" do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end


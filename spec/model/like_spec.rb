require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  let(:like) { FactoryBot.create(:like, author: user, post: post) }

  describe "associations" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe "#update_post_likes_counter" do
    it "increments the post's likes_counter when a like is created" do
      expect { like }.to change { post.reload.likes_counter }.by(1)
    end

    it "decrements the post's likes_counter when a like is destroyed" do
      like.destroy
      expect(post.reload.likes_counter).to eq(0)
    end
  end
end

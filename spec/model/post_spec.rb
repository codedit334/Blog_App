require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe '#recent_comments' do
    it 'returns the five most recent comments on the post' do
      FactoryBot.create(:comment, post:, created_at: 7.days.ago)
      recent_comments = FactoryBot.create_list(:comment, 5, post:)
      expect(post.recent_comments).to eq(recent_comments.reverse)
    end
  end

  describe '#update_user_posts_counter' do
    it "increments the author's posts_counter when a post is created" do
      expect { post }.to change { user.reload.posts_counter }.by(1)
    end

    it "decrements the author's posts_counter when a post is destroyed" do
      post.destroy
      expect(user.reload.posts_counter).to eq(0)
    end
  end

  describe 'validations' do
    let(:post) { FactoryBot.build(:post, author: user) }

    it 'is valid with valid attributes' do
      expect(post).to be_valid
    end

    it 'is invalid without a title' do
      post.title = nil
      expect(post).to be_invalid
    end

    it 'is invalid if the title is too long' do
      post.title = 'a' * 251
      expect(post).to be_invalid
    end

    it 'is invalid if the comments_counter is negative' do
      post.comments_counter = -1
      expect(post).to be_invalid
    end

    it 'is invalid if the likes_counter is negative' do
      post.likes_counter = -1
      expect(post).to be_invalid
    end

    it 'is valid if the comments_counter and likes_counter are zero' do
      post.comments_counter = 0
      post.likes_counter = 0
      expect(post).to be_valid
    end
  end
end

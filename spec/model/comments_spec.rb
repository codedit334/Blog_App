require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  let(:comment) { FactoryBot.create(:comment, author: user, post: post) }
  
  describe "associations" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe "#update_post_comments_counter" do
    it "increments the post's comments_counter when a comment is created" do
      expect { comment }.to change { post.reload.comments_counter }.by(1)
    end

    it "decrements the post's comments_counter when a comment is destroyed" do
      comment.destroy
      expect(post.reload.comments_counter).to eq(0)
    end
  end
end

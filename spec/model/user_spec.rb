require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:likes).with_foreign_key('author_id') }
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments).with_foreign_key('author_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_posts' do
    let(:user) { FactoryBot.create(:user) }
    let!(:post1) { FactoryBot.create(:post, author: user) }
    let!(:post2) { FactoryBot.create(:post, author: user) }
    let!(:post3) { FactoryBot.create(:post, author: user) }
    let!(:post4) { FactoryBot.create(:post, author: user) }

    it 'returns the three most recent posts' do
      expect(user.recent_posts).to eq([post4, post3, post2])
    end

    it 'does not return posts older than three days' do
      expect(user.recent_posts).not_to include(post1)
    end
  end
end

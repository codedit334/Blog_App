class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end

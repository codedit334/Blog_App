class User < ApplicationRecord
  # has_one_attached :photo
  has_many :likes, foreign_key: 'author_id' # specify the custom foreign key name
  has_many :posts, foreign_key: 'author_id' # specify the custom foreign key name
  has_many :comments, foreign_key: 'author_id' # specify the custom foreign key name
end

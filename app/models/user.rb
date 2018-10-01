class User < ApplicationRecord
  has_many :posts

  has_many :comments
  has_many :commented_posts, through: :comments, source: :commentable, source_type: :Post
  has_many :commented_users, through: :comments, source: :commentable, source_type: :User

  # has_many :comments, as: :commentable
  # has_many :commenters, through: :comments, as: :commentable, source: :user

  has_many :marks
  has_many :marked_posts, through: :marks, source: :post

  has_one :seo, as: :seoable

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 16 }
  validates :name, uniqueness: true
end

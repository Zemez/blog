class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :commentable, source_type: :Post
  has_many :commented_users, through: :comments, source: :commentable, source_type: :User

  # has_many :comments, as: :commentable
  # has_many :commenters, through: :comments, as: :commentable, source: :user

  has_many :marks, dependent: :destroy
  has_many :marked_posts, through: :marks, source: :post

  has_one :seo, as: :seoable

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 16 }
  validates :name, uniqueness: true
  def role
    moderator ? 'Moderator' : ( creator ? 'Creator' : 'User' ) 
  end
end

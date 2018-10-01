class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :commenters, through: :comments, source: :user

  has_many :marks
  has_many :markers, through: :marks, source: :user

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :title, length: { minimum: 8, maximum: 255 }

  validates :body, presence: true
  validates :body, length: { minimum: 1, maximum: 4096 }

  scope :moderators, -> { joins(:user).where(users: { moderator: true }) }

  # def self.moderators
  #   # этот чуть помедленней работает
  #   # where(user: User.where(moderator: true))
  #   # этот вроде шустрее работает, хотя explain показывает абсолютно идентичные данные
  #   joins(:user).where(users: { moderator: true })
  # end
end

class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :title, length: { minimum: 8, maximum: 255 }

  validates :body, presence: true
  validates :body, length: { minimum: 1, maximum: 8192 }
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true
  validates :body, length: { minimum: 1, maximum: 1024 }
end

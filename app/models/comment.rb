class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :commentable, polymorphic: true

  has_many :seoes, as: :seoable

  validates :body, presence: true
  validates :body, length: { minimum: 1, maximum: 1024 }
end

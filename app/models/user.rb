class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 4, maximum: 16 }
  validates :name, uniqueness: true
end

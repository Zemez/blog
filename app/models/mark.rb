class Mark < ApplicationRecord
  MIN_MARK = 1
  MAX_MARK = 5

  belongs_to :user
  belongs_to :post

  validates :mark, presence: true
  validates :mark, numericality: { only_integer: true }
  validates :mark, inclusion: MIN_MARK..MAX_MARK

  validates :user_id, uniqueness: { scope: :post_id }
end

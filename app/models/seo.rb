class Seo < ApplicationRecord
  belongs_to :seoable, polymorphic: true
end

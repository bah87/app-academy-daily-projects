class Vote < ApplicationRecord
  validates :value, default: 0
  belongs_to :voteable, polymorphic: true
end

class Goal < ApplicationRecord
  
  validates :user, :title, :details, presence: true
  
  belongs_to :user
  has_many :comments
  
end

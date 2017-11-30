# == Schema Information
#
# Table name: bands
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

class Band < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :user
  
  has_many :albums
end

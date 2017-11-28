# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Cat < ApplicationRecord
  COLORS = ['orange', 'black', 'white', 'gray']
  
  validates :birth_date, :name, presence: true
  validates :sex, inclusion: {in: ['M', 'F']}
  validates :color, inclusion: {in: COLORS}
  
  has_many :cat_rental_requests,
  dependent: :destroy
  
  def age
    days = (DateTime.now - self.birth_date).to_i
    days/12 < 12 ? "#{days/12} months" : "#{days/365} years"
  end 
  
end

require 'rails_helper'

RSpec.describe Goal, type: :model do
  
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:details) }
  end
  
  describe 'associations' do
    it { should have_many(:comments) } 
    it { should belong_to(:user) }
  end
  
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6).on(:initialize) }
  end
  
  describe 'uniqueness' do
    subject { User.create(session_token: "ksdjfndfk", password_digest: "dkjfndfk", username: "new_user_1")}
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end
  
  describe 'associations' do
    it { should have_many(:goals) }
    it { should have_many(:comments) }
  end
  
  describe '::find_by_credentials' do
    it 'successfully finds user given correct credentials' do
      u = User.create(username: 'user', password: 'password')
      expect(User.find_by_credentials('user', 'password')).to eq(u)
    end
    
    it 'returns nil given incorrect credentials' do
      u = User.create(username: 'user', password: 'password')
      expect(User.find_by_credentials('user', '')).to eq(nil)
    end
  end
end

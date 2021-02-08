require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do 
    it 'should test that factory is valid' do 
      expect(build :user).to be_valid
    end
    it 'should validates presence of attributes' do
      user = build :user, login: nil, provider: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:login]).to eq(["can't be blank"])
      expect(user.errors.messages[:provider]).to eq(["can't be blank"])
    end
    it 'should validates uniqueness of login' do 
      user = create :user
      user_2 = build :user, login: user.login
      expect(user_2).not_to be_valid
      user_2.login = 'New_login'
      expect(user_2).to be_valid
    end
  end
end

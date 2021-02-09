require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe '#validations' do 
    it 'should test that factory is valid' do 
      expect(build :access_token).to be_valid
    end
    it 'should validates presence of token' do 
      invalid_token = build :access_token, token: nil, user_id: nil 
      expect(invalid_token).not_to be_valid
      expect(invalid_token.errors.messages[:token]).to eq(["can't be blank"])
    end
    it 'should validates uniqueness of token' do 
      token = create :access_token
      new_token = build :access_token, token: token.token
      expect(new_token).not_to be_valid
      new_token.token = "New login"
      expect(new_token).to be_valid
    end
  end

  describe '#new' do 
    it 'should have a token present after initialize' do 
      expect(AccessToken.new.token).to be_present
    end
    it 'should generate uniq token' do 
      user = create :user
      expect{ user.create_access_token}.to change{ AccessToken.count }.by(1)
      expect(user.build_access_token).to be_valid
    end
    it 'should generate token once' do 
      user = create :user 
      access_token = user.create_access_token
      expect(access_token.token).to eq(access_token.reload.token)
    end
  end
end

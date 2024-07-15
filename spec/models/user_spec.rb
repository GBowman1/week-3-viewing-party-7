require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
  end 

  it 'Hashes password' do
    user = User.create(name: 'User One', email: 'usone@aol.com', password: 'password123')
    expect(user.password_digest).to be_a(String)
    expect(user.password_digest).to_not eq('password123')
    expect(user).to_not have_attribute(:password)
  end
  
end

require 'rails_helper'

# As a registered user
# When I visit the landing page `/`
# I see a link for "Log In"
# When I click on "Log In"
# I'm taken to a Log In page ('/login') where I can input my unique email and password.
# When I enter my unique email and correct password 
# I'm taken to my dashboard page

RSpec.describe 'Login Page' do
  it 'has a link to log in' do
    user1 = User.create(name: "User One", email: "usone@aol.com", password: 'password123')

    visit '/'
    expect(page).to have_button('Login')
    click_button 'Login'
    expect(current_path).to eq(login_path)

    fill_in :email, with: user1.email
    fill_in :password, with: user1.password

    click_button 'Login'

    expect(current_path).to eq(user_path(user1.id))

  end

  it 'does not login if password doesnt match' do
    user1 = User.create(name: "User One", email: "sadad@aol.com", password: 'password123')

    visit '/'

    click_button 'Login'

    fill_in :email, with: user1.email
    fill_in :password, with: 'password1234'

    click_button 'Login'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Invalid email or password')
  end
end
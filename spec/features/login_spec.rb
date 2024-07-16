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

  it 'shows location on user show when cookie is present' do
    user = User.create(name: "User One", email: "user@aol.com", password: 'password123')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :location, with: 'Denver, CO'

    click_button 'Login'

    expect(current_path).to eq(user_path(user.id))
    expect(page).to have_content('Denver, CO')
  end

  it 'does not show location on user show when cookie is not present' do
    user = User.create(name: "User One", email: "user@aol.com", password: 'password123')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button 'Login'

    expect(current_path).to eq(user_path(user.id))
    expect(page).to_not have_content('Denver, CO')
  end

  it 'can log out' do
    user = User.create(name: "User One", email: "user@aol.com", password: 'password123')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button 'Login'

    expect(current_path).to eq(user_path(user.id))

    visit root_path
    expect(page).to_not have_button('Login')

    click_button 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_button('Login')
  end

  it 'doesnt allow user to view user show page if not logged in' do
    user = User.create(name: "User One", email: "user@aol.com", password: 'password123')

    visit user_path(user.id)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You must be logged in to view this page')
  end

  
end
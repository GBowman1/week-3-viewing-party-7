require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123")
    i = 1
    20.times do 
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
      i+=1
    end 
  end 

  it 'shows all movies' do
    visit login_path
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_button 'Login'


    visit "users/#{@user1.id}"

    click_button "Find Top Rated Movies"

    expect(current_path).to eq("/users/#{@user1.id}/movies")

    expect(page).to have_content("Top Rated Movies")
    
    movie_1 = Movie.first

    click_link(movie_1.title)

    expect(current_path).to eq("/users/#{@user1.id}/movies/#{movie_1.id}")

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.description)
    expect(page).to have_content(movie_1.rating)
  end 

  it "doesnt allow visitor to make a viewing party without logging in" do
    visit movie_path(@user1.id, Movie.first.id)

    click_button "Create a Viewing Party"

    expect(current_path).to eq(movie_path(@user1.id, Movie.first.id))
    expect(page).to have_content("You must be logged in to view this page")
  end
end
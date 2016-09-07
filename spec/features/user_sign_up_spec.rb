require 'spec_helper'

feature 'user sign up' do

  # scenario 'new user signs up' do
  #   visit '/sign-up'
  #   fill_in 'username', with: 'Santa'
  #   fill_in 'email', with: 'santa@northpole.com'
  #   visit '/'
  #   expect{click_button 'Sign Up'}.to change{User.count}.by(1)
  #   expect(page).to have_content 'Welcome, Santa!'
  # end

  scenario 'user information is saved to database' do
    user_signup
    user = User.first
    expect(user.username).to eq 'Santa'
    expect(user.email).to eq 'santa@northpole.com'
  end

  scenario 'user is welcomed once signed up' do
    user_signup
    expect(page).to have_content('Welcome Santa!')
  end
end

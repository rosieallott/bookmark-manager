require 'spec_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    expect(page.status_code).to eq(200)
    expect(User.all.size).to eq 1
    expect(page).to have_content('Welcome, testuser1@john.com')
    expect(User.first.email).to eq('testuser1@john.com')
  end

  scenario 'Passwords must match' do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password2')
    expect(User.all.size).to eq 0
    expect(current_path).to eq '/users/new'
    expect(page).to have_content 'Password does not match the confirmation'
    expect(find_field('email').value).to eq 'testuser1@john.com'
  end

  scenario 'users cannot sign up with empty email address' do
    sign_up(email: '', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    expect(page).to have_content 'Email must not be blank'
    expect(User.all.size).to eq 0
  end

  scenario 'users cannot sign up with invalid email address' do
    sign_up(email: 'abc', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    expect(page).to have_content 'Email has an invalid format'
    expect(User.all.size).to eq 0
  end

  scenario 'users cannot sign up twice' do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    expect(User.all.size).to eq 1
    expect(page).to have_content 'Email is already taken'
  end
end

feature "User sign in" do

  scenario "user can sign in with proper credintials" do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    sign_up(email: 'testuser2@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    sign_in(email: 'testuser1@john.com', password: 'my_secret_password')
    expect(page).to have_content("Welcome, testuser1@john.com")
  end

  scenario "user cannot sign in with wrong email and/or password" do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    sign_in(email: 'testuser2@john.com', password: 'my_secret_password')
    expect(page).to have_content("Username or password is not correct")
  end

end

feature 'User sign out' do

  scenario 'user can sign out and goodbye message is shown' do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    sign_in(email: 'testuser1@john.com', password: 'my_secret_password')
    click_button 'Sign out'

    expect(page).to have_content 'Goodbye!'
    expect(current_path).to eq '/links'
  end
end

feature 'password recovery' do

  scenario 'valid user can request password reset token' do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    visit '/sessions/new'
    click_button 'Forgot my password'
    fill_in :email, with: 'testuser1@john.com'
    expect(current_path).to eq '/sessions/reset'
    fill_in :password, with: 'my_new_secret_password'
    fill_in :password_confirmation, with: 'my_new_secret_password'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome, testuser1@john.com'
  end

  scenario 'invalid user receives error msg when trying to reset password' do
    visit '/sessions/new'
    click_button 'Forgot my password'
    fill_in :email, with: 'testuser1@john.com'
    expect(page).to have_content 'Not a known user'
  end
end

require 'spec_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    sign_up
    fill_in :password_confirmation, with: 'my_secret_password'
    expect{ click_button 'Sign up' }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, testuser1')
    expect(User.first.email).to eq('testuser1@john.com')
  end

  scenario 'Passwords must match' do
    sign_up
    fill_in :password_confirmation, with: 'my_secret_password2'
    expect { click_button 'Sign up' }.to change(User, :count).by 0
    expect(current_path).to eq '/users/new'
    expect(page).to have_content 'Password does not match the confirmation'
    expect(find_field('email').value).to eq 'testuser1@john.com'
  end

  scenario 'users cannot sign up with empty email address' do
    one_valid_passwords
    fill_in :email, with: ''
    expect { click_button 'Sign up' }.to change(User, :count).by 0
  end

  scenario 'users cannot sign up with invalid email address' do
    one_valid_passwords
    fill_in :email, with: 'abc'
    expect { click_button 'Sign up' }.to change(User, :count).by 0
  end

  scenario 'users cannot sign up twice' do
    one_valid_user
    click_button 'Sign up'
    one_valid_user
    expect { click_button 'Sign up' }.to change(User, :count).by 0
    expect(page).to have_content 'Email is already taken'
  end
end

feature "User sign in" do

  scenario "user can sign in with proper credintials" do
    sign_up
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    another_sign_up
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    visit '/sessions/new'
    fill_in(:email, with: 'testuser1@john.com')
    fill_in(:password, with: 'my_secret_password')
    click_button 'Sign in'

    expect(page).to have_content("Welcome, testuser1@john.com")
  end

  scenario "user cannot sign in with wrong email and/or password" do
    sign_up
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    visit '/sessions/new'
    fill_in(:email, with: 'testuser1@john.com')
    fill_in(:password, with: 'other_password')
    click_button 'Sign in'

    expect(page).to have_content("Username or password is not correct")

  end

end

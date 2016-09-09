require 'spec_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    sign_up(email: 'testuser1@john.com', password: 'my_secret_password', password_confirmation: 'my_secret_password')
    expect(page.status_code).to eq(200)
    expect(User.all.size).to eq 1
    expect(page).to have_content('Welcome, testuser1')
    expect(User.first.email).to eq('testuser1@john.com')
  end

  scenario 'Passwords must match' do
    visit '/users/new'
    fill_in :email, with: 'testuser1@john.com'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password2'
    expect { click_button 'Sign up' }.to change(User, :count).by 0
    expect(current_path).to eq '/users/new'
    expect(page).to have_content 'Password does not match the confirmation'
    expect(find_field('email').value).to eq 'testuser1@john.com'
  end

  scenario 'users cannot sign up with empty email address' do
    visit '/users/new'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    fill_in :email, with: ''
    expect { click_button 'Sign up' }.to change(User, :count).by 0
  end

  scenario 'users cannot sign up with invalid email address' do
    visit '/users/new'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    fill_in :email, with: 'abc'
    expect { click_button 'Sign up' }.to change(User, :count).by 0
  end

  scenario 'users cannot sign up twice' do
    visit '/users/new'
    fill_in :email, with: 'valid@john.com'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    visit '/users/new'
    fill_in :email, with: 'valid@john.com'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    expect { click_button 'Sign up' }.to change(User, :count).by 0
    expect(page).to have_content 'Email is already taken'
  end
end

feature "User sign in" do

  scenario "user can sign in with proper credintials" do
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: 'testuser1@john.com'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: 'testuser2@john.com'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    visit '/sessions/new'
    fill_in(:email, with: 'testuser1@john.com')
    fill_in(:password, with: 'my_secret_password')
    click_button 'Sign in'

    expect(page).to have_content("Welcome, testuser1@john.com")
  end

  scenario "user cannot sign in with wrong email and/or password" do
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: 'testuser1@john.com'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    visit '/sessions/new'
    fill_in(:email, with: 'testuser1@john.com')
    fill_in(:password, with: 'other_password')
    click_button 'Sign in'

    expect(page).to have_content("Username or password is not correct")
  end

end

feature 'User sign out' do

  scenario '' do
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: 'testuser1@john.com'
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    click_button 'Sign up'
    visit '/sessions/new'
    fill_in(:email, with: 'testuser1@john.com')
    fill_in(:password, with: 'my_secret_password')
    click_button 'Sign in'
    click_button 'Sign out'

    expect(page).to have_content 'Goodbye!'
    expect(current_path).to eq '/links'
  end
end

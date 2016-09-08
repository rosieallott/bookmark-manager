require 'spec_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    sign_up
    fill_in :password_confirmation, with: 'my_secret_password'
    expect{ click_button 'Sign up' }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, testuser1')
    expect(User.first.email).to eq('testuser1')
  end

  scenario 'Paswords must match' do
    sign_up
    fill_in :password_confirmation, with: 'my_secret_password2'
    expect { click_button 'Sign up' }.to change(User, :count).by 0
    expect(current_path).to eq '/users/new'
    expect(page).to have_content 'Password and confirmation password do not match'
    expect(find_field('email').value).to eq 'testuser1'
  end

  scenario 'users cannot sign up with empty email address' do
    visit '/users/new'
    fill_in :email, with: ''
    fill_in :password, with: 'my_secret_password'
    fill_in :password_confirmation, with: 'my_secret_password'
    expect { click_button 'Sign up' }.to change(User, :count).by 0
  end

end

def sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email, with: 'testuser1@john.com'
  fill_in :password, with: 'my_secret_password'
end

def another_sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email, with: 'testuser2@john.com'
  fill_in :password, with: 'my_secret_password'
end

def one_valid_passwords
  visit '/users/new'
  fill_in :password, with: 'my_secret_password'
  fill_in :password_confirmation, with: 'my_secret_password'
end

def one_valid_user
  visit '/users/new'
  fill_in :email, with: 'valid@john.com'
  fill_in :password, with: 'my_secret_password'
  fill_in :password_confirmation, with: 'my_secret_password'
end

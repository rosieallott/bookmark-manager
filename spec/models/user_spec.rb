require_relative '../../app/models/user.rb'

describe User do

  let!(:user) do User.create(email: "testuser1@john.com",
                             password: "my_secret_password",
                             password_confirmation: "my_secret_password")
  end

  context '#authenticate' do
    it 'authenticates the user and returns the user object if authentication complete' do
      expect(User.authenticate("testuser1@john.com", "my_secret_password")).to eq user
    end

    it 'authentication fails because of wrong password' do
      expect(User.authenticate("testuser1@john.com", "other_password")).to eq false
    end

    it 'authentication fails because of wrong email' do
      expect(User.authenticate("testuser1@rosie.com", "my_secret_password")).to eq false
    end

  end

end

require 'bcrypt'

class User

  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :username, String
  property :email, String

  property :password_safe, Text

  def password=(password)
    self.password_safe = BCrypt::Password.create(password)
  end

end

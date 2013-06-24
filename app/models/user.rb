class User < ActiveRecord::Base
  has_many :exchanges
  has_many :crushes
  has_many :free_times

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(user_info)
    user = User.find_by_email(user_info[:email])
    return user if user.password == user_info[:password]
  end

end

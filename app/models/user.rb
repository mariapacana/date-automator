class User < ActiveRecord::Base
  has_many :messages
  has_many :crushes
  has_many :free_times

  validates :first_name, :last_name, :email, :phone, :password_hash, :presence => true
  validates :email, :format => { :with => /.*@.*\..*/,
    :message => "must be valid" }
  validates :phone, :format => { :with => /1?(-|.)?\d{3}(-|.)?\d{3}(-|.)?\d{4}/,
    :message => "must be valid" }

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

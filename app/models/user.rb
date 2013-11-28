class User < ActiveRecord::Base
  has_many :exchanges
  has_many :crushes
  has_many :free_times
  has_many :authorizations

  validates_uniqueness_of :email, :scope => :phone_number

  validates :first_name, :last_name, :email, :phone_number, :password_hash, :presence => true
  validates :email, :format => { :with => /.*@.*\..*/,
    :message => "must be valid" }
  validates :phone_number, :format => { :with => /\+1(-|.)?\d{3}(-|.)?\d{3}(-|.)?\d{4}/,
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

  def google_access_token
    puts authorizations.find_by_auth_type("google")
    if authorizations.find_by_auth_type("google")
      authorizations.find_by_auth_type("google").access_token
    else
      nil
    end
  end

end

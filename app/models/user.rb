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
    if user.nil? 
      "Please sign up."
    elsif user.password != user_info[:password]
      "Your password is incorrect"
    else
      user
    end
  end

  def disable_google
    self.update_attributes(google_opt_out: true) if self.google_opt_out.nil?
  end

  def enabled_google_oauth?
    google_authorization ? true : false
  end

  def google_authorization
    authorizations.find_by_auth_type("google")
  end

  def google_access_token
    enabled_google_oauth? ? google_authorization.access_token : nil
  end

  def google_refresh_token
    enabled_google_oauth? ? google_authorization.refresh_token : nil
  end

  def google_access_token_outdated?
    google_authorization.updated_at < 1.hour.ago
  end

  def update_google_access_token(new_token)  
    google_authorization.update_attributes(access_token: new_token)
  end

end

class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :crush

  def interested
    send_sms("+16506459949", crush["phone"], "Hi there! Are you interested in #{currentuser.first_name}?")
  	
  end
end

class Exchange < ActiveRecord::Base
  belongs_to :user
  belongs_to :phone

  before_create :set_pin_and_text
  before_update :send_new_message

  def set_pin_and_text
    set_pin
    set_text
  end

  def set_pin
    self.pin = phone.next_pin 
    phone.increment_pin
  end

  def crush
    Crush.find_by_user_id_and_phone_id(self.user.id, self.phone.id)
  end

  def user_name
    self.user.first_name
  end

  def set_text
    case crush.status
    when "not contacted"
      self.request_text = "Hello! Are you interested in #{self.user_name}? Text Yes #{self.pin} or No #{self.pin} to respond."
    else
      self.request_text = "Yeah, you like me, don't you!"
    end
  end

  def send_new_message
    case request_text 
    when "Yes"
      crush.update_attributes(status: "interested")
      Exchange.create(user: self.user, phone: self.phone)
    else
      crush.update_attributes(status: "not interested")
    end
  end 
end

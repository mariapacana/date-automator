class Exchange < ActiveRecord::Base
  belongs_to :user
  belongs_to :phone

  before_create :set_pin

  def set_pin
    self.pin = phone.next_pin 
    phone.increment_pin
  end

end

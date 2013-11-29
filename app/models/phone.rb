class Phone < ActiveRecord::Base
  has_many :crushes  
  has_many :exchanges

  validates_uniqueness_of :phone_number
  validates :phone_number, :format => { :with => /\+1(-|.)?\d{3}(-|.)?\d{3}(-|.)?\d{4}/,
    :message => "must be valid" }
  after_initialize :init

  def init
    self.next_pin ||= 1
  end

  def increment_pin
    self.next_pin += 1
  end

end
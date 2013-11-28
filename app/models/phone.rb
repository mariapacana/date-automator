class Phone < ActiveRecord::Base
  has_many :crushes  
  has_many :exchanges

  validates_uniqueness_of :phone_number
end
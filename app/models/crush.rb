class Crush < ActiveRecord::Base
  has_many :exchanges
  belongs_to :user
end

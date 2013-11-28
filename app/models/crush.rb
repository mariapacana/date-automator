class Crush < ActiveRecord::Base
  has_many :exchanges
  belongs_to :user
  belongs_to :phone

  validates_uniqueness_of :phone_id, :scope => :user_id
end

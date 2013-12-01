class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :auth_type, :scope => :user_id

end

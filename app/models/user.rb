class User < ActiveRecord::Base
  has_many :exchanges
  has_many :free_times
end

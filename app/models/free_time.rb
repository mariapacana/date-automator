class FreeTime < ActiveRecord::Base
  belongs_to :user

  def start_time_formatted
    start_time.strftime("%D, %H:%M")
  end

end

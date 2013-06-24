class FreeTime < ActiveRecord::Base
  belongs_to :user

  def start_time_formatted
    start_time.strftime("%D (%A) at %H:%M")
  end

end

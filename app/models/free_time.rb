class FreeTime < ActiveRecord::Base
  belongs_to :user

  def start_time_formatted
    start_time.strftime("%H:%M")
  end

  def end_time_formatted
    end_time.strftime("%H:%M")
  end
end

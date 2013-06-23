helpers do

  def start_time(free_date, start_time)
    Time.parse(free_date + " " + start_time)
  end

  def end_time(free_date, end_time)
    Time.parse(free_date + " " + end_time)
  end

end

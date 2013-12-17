helpers do

  def start_time(free_date, start_time)
    Time.parse(free_date + " " + start_time)
  end

  def gcal_format(time)
    time.gmtime.strftime "%Y-%m-%dT%H:%M:%SZ"
  end

end

get '/' do
  erb :index
end

get '/schedule' do
  @times = currentuser.free_times
  erb :_dates
end

post '/schedule' do 
  p params
  params.each do |index, freetime|
    start_time = start_time(freetime[:free_date], freetime[:start_time])
    currentuser.free_times.create(start_time: start_time)
  end
  @times = currentuser.free_times
  erb :_all_free_dates, {:layout => false}
end

get '/crushes' do
  @crushes = currentuser.crushes
  erb :_crushes
end

post '/crushes' do
  params.each do |index, crush|
    currentuser.crushes.create(crush)
  end
  @crushes = currentuser.crushes
  erb :_all_crushes, {:layout => false}
end


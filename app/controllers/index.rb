get '/' do
  erb :index
end

get '/schedule' do
  erb :_dates
end

post '/schedule' do 
  params.each do |index, freetime|
    start_time = start_time(freetime[:free_date], freetime[:start_time])
    currentuser.free_times.create(start_time: start_time)
  end
  @time = currentuser.free_times.last
  erb :_free_dates
end

get '/crushes' do
  erb :_crushes
end

post '/crushes' do
  crushes.create(params[:crush])
  p currentuser
  redirect '/crushes'
end

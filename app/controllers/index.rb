get '/' do
  erb :index
end

get '/schedule' do
  erb :_dates
end

post '/schedule' do 
  start_time = start_time(params[:free_date], params[:start_time])
  end_time = end_time(params[:free_date], params[:end_time])
  currentuser.free_times.create(free_date: params[:free_date],
                                start_time: start_time,
                                end_time: end_time)
end

get '/crushes' do
  erb :_crushes
end

post '/crushes' do
  crushes.create(params[:crush])
  p currentuser
  redirect '/crushes'
end

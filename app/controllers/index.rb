get '/' do
  erb :index
end

get '/schedule' do
  erb :_dates
end

post '/schedule' do
  FreeTime.create(params[:free_time])
end

get '/crushes' do
  erb :_crushes
end

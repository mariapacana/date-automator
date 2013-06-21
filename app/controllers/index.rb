get '/' do
  erb :index
end

get '/schedule' do
  erb :_dates
end

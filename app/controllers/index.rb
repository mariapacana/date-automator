get '/' do
  erb :index
end

get '/schedule' do
  erb :_dates
end

get '/crushes' do
  erb :_crushes
end

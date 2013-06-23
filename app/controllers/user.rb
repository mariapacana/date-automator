post '/login' do
  user = User.authenticate(params[:email], params[:password])
  session[:user_id] = user.id if user
  redirect '/'
end

post '/signup' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end


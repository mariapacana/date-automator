post '/login' do
  user_info = params[:user]
  
  if !errors(user_info).empty?
    @login_errors = errors(user_info)
  else
    user = User.authenticate(params[:user])
    session[:user_id] = user.id if user.is_a? User
    @login_errors = [user]
  end

  erb :index
end

post '/signup' do
  user_info = process_signup(params[:user])
  user = User.create(user_info)
  @errors = user.errors.full_messages
  session[:user_id] = user.id if user

  erb :index
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/user/:user_id' do
  erb :not_done
end
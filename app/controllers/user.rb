post '/login' do
  userinfo = params[:user]
  @errors = []

  if userinfo[:email].blank? || userinfo[:password].blank?
    @errors << "Email cannot be blank" if userinfo[:email].blank?
    @errors << "Password cannot be blank" if userinfo[:password].blank?
  else
    user = User.authenticate(params[:user])
    session[:user_id] = user.id if user
  end

  erb :index
end

post '/signup' do
  user = User.create(params[:user])
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
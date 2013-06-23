helpers do

  def currentuser
      User.find_by_id(session[:user_id]) if session[:user_id]
  end

end

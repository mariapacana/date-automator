helpers do

  def currentuser
      User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def process_signup(params)
    phone = params.fetch("phone_number")
    params["phone_number"] = standardize_phone(phone)
    params
  end

  def valid_user(params)
    User.authenticate(params[:user])
  end
end

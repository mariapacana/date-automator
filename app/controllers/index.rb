get '/' do
  erb :index
end

get '/oauth_google' do
  redirect display_oauth_google
end

get '/all_contacts' do
  refresh_access_token_if_needed(currentuser)
  @contacts = import_contacts(currentuser)
  @contacts.to_json
end

get '/opt_out_google' do
  currentuser.disable_google
  "200 OK"
end

get '/get_photo' do
  parser = ContactParser.new(currentuser)
  @contact = params 
  photo = parser.photo_req(@contact[:id])
  if photo != "404" && photo != "530"
    @contact[:photo] = photo
    erb :_contact, {:layout => false}
  else
    "Error"
  end
end

get '/crushes' do
  if params[:code]
    get_access_token(params[:code]) 
  end
  @crushes = currentuser.crushes
  erb :_crushes
end

post '/crushes' do
  params.each do |index, crush|
    phone = Phone.create(phone_number: standardize_phone(crush["phone"]))
    crush["phone"] = phone
    crush["status"] = "not contacted"
    @new_crush = currentuser.crushes.create(crush)
    exchange = Exchange.create(user: currentuser, phone: phone)
    @new_crush.update_attributes(status: "contacted")
    send_sms(ENV['TW_PHONE'], @new_crush.phone.phone_number, 
                              exchange.request_text)
  end
  @crushes = currentuser.crushes
  erb :_all_crushes, {:layout => false}
end

post '/receive' do
  response_text, pin = params[:Body].split(" ")

  if pin
    phone = params[:From]
    phone = Phone.find_by_phone_number(phone)
    exchange = Exchange.find_by_pin_and_phone_id(pin, phone.id)
    exchange.update_attributes(response_text: response_text)
    case response_text
    when "Yes" 
      exchange.crush.update_attributes(status: "interested")
      new_exchange = Exchange.create(user: exchange.user, phone: phone)
      send_sms(ENV['TW_PHONE'], phone.phone_number, new_exchange.request_text)
    else
      puts "UGH================================="
      # exchange.crush.update_attributes(status: "not interested")
    # end
    end 
  end
end
 
get '/schedule' do
  @times = currentuser.free_times
  erb :_dates
end

get '/about' do
  erb :about
end

post '/schedule' do 
  params.each do |index, freetime|
    start_time = start_time(freetime[:free_date], freetime[:start_time])
    currentuser.free_times.create(start_time: start_time)
  end
  @times = currentuser.free_times
  erb :_all_free_dates, {:layout => false}
end
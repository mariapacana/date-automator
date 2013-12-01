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

get '/refresh' do
  refresh_access_token(currentuser)
end

get '/get_photo' do
  parser = ContactParser.new(currentuser)
  binding.pry 
  @photo = parser.photo_req(params[:id])
  if @photo != "404" && @photo != "530"
    
    # @last_name = params[:last_name]
    # @first_name = params[:first_name]
    # @id = params[:id]
    # @phone = params[:phone]
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
  hello = "Hi there! Are you interested in #{currentuser.first_name}?"
  params.each do |index, crush|
    standardize_phone(crush["phone"])
    crush.pry
    send_sms(ENV['TW_PHONE'], crush["phone"], hello)
    @new_crush = currentuser.crushes.create(crush)
  end

  currentuser.crushes
  @crushes = currentuser.crushes
  erb :_all_crushes, {:layout => false}
end

post '/receive' do
  puts "RECEIVED======================================"
  @crush_phone = params[:From]
  @message =  params[:Body]

  if @crush = Crush.find_by_phone(@crush_phone)
    if (@message == "Yes")
      @crush.update_attributes(status: "interested")
    else
      @crush.update_attributes(status: "not interested")
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
  p params
  params.each do |index, freetime|
    start_time = start_time(freetime[:free_date], freetime[:start_time])
    currentuser.free_times.create(start_time: start_time)
  end
  @times = currentuser.free_times
  erb :_all_free_dates, {:layout => false}
end
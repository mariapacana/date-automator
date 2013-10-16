get '/' do
  erb :index
end

get '/oauth_google' do
  client = Google::APIClient.new((options = 
                                 {application_name: "Date Automator", 
                                  application_version: "1"}))
  client.authorization.client_id = ENV['G_ID']
  client.authorization.client_secret = ENV['G_SECRET']
  client.authorization.redirect_uri = ENV['G_CALLBACK']
  client.authorization.scope = ENV['G_CONTACTS_SCOPE']
  p "AUTHORIZATION URI!!........................."
  redirect client.authorization.authorization_uri.to_s[1..-1]
end

# get '/oauth2callback' do
#   p "Hey logz.................................."
#   p params
# end

post '/receive' do
  # need to massage phone number into a standard format
  p params
  
  @crush_phone = params[:From]
  @message =  params[:Body]

  @crush = Crush.find_by_phone(@crush_phone)
  if (@message == "Yes")
    @crush.update_attributes(interested: true)
  else
    @crush.update_attributes(interested: false)
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

get '/crushes' do
  @crushes = currentuser.crushes
  erb :_crushes
end

post '/crushes' do
  hello = "Hi there! Are you interested in #{currentuser.first_name}?"
  params.each do |index, crush|
    send_sms("+16506459949", crush["phone"], hello)
    @new_crush = currentuser.crushes.create(crush)
    currentuser.messages.create(body: hello, from_user: true, crush: @new_crush)
  end

  @crushes = currentuser.crushes
  erb :_all_crushes, {:layout => false}
end
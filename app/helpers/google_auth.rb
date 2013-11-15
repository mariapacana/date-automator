helpers do
	def initialize_client
		client = Google::APIClient.new((options = 
																	 {application_name: "Date Automator", 
																		application_version: "1"}))
    client.authorization.client_id = ENV['G_ID']
    client.authorization.client_secret = ENV['G_SECRET']
    client.authorization.redirect_uri = ENV['G_CALLBACK']
		client.authorization.scope = [ENV['G_CONTACTS_SCOPE'],
                                  ENV['G_PLUS_SCOPE'],
                                  ENV['G_CAL_SCOPE']].join(" ")
	  client
	end
    
  def display_oauth_google
  	client = initialize_client
  	client.authorization.authorization_uri.to_s
  end  

  def get_access_token(code)
  	client = initialize_client
  	client.authorization.code = code
  	token = client.authorization.fetch_access_token!
    currentuser.authorizations.create({auth_type: "google",
                                      access_token: token['access_token'],
                                      refresh_token: token['refresh_token']})
  end

  def get_data(request)
    parsed_url = URI.parse(request)
    puts "url host #{parsed_url.host}, url port #{parsed_url.port}"
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(parsed_url.request_uri)
    response = http.request(request)
    response.body
  end

  def import_contacts(currentuser)
    parser = ContactParser.new(currentuser)
    contact_info = get_data(parser.contact_req)
    parser.get_formatted_contacts(contact_info)
  end

  def import_plus(currentuser)
    body = get_data(ContactParser.plus_req(currentuser))
  end

  def one_plus(currentuser, id)
    body = get_data(ContactParser.one_plus_req(currentuser, id))
  end

  def search_plus(currentuser, name)
    body = get_data(ContactParser.search_plus_req(currentuser, name))
  end

end

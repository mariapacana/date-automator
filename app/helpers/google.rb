helpers do

	def initialize_client
		client = Google::APIClient.new((options = 
																	 {application_name: "Date Automator", 
																		application_version: "1"}))
    client.authorization.client_id = ENV['G_ID']
    client.authorization.client_secret = ENV['G_SECRET']
    client.authorization.redirect_uri = ENV['G_CALLBACK']
		client.authorization.scope = ENV['G_CONTACTS_SCOPE']
	  
	end
    
  def display_oauth_google
  	initialize_client
  	client.authorization.authorization_uri.to_s
  end  

  def get_access_token(code)
  	initialize_client
  	client.authorization.code = code
  	client.authorization.fetch_access_token!
  end
end

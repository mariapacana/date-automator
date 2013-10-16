helpers do

	def initialize_client
		client = Google::APIClient.new((options = 
																	 {application_name: "Date Automator", 
																		application_version: "1"}))
    client.authorization.client_id = ENV['G_ID']
    client.authorization.client_secret = ENV['G_SECRET']
    client.authorization.redirect_uri = ENV['G_CALLBACK']
		client.authorization.scope = ENV['G_CONTACTS_SCOPE']
		return client
	end

	def obtain_callback_url(client)
		p "WE ARE IN CALLBACK URL"
    p client.authorization.authorization_uri
	end
end

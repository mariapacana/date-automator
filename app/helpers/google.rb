helpers do

	def initialize_client
		client = Google::APIClient.new
    client.authorization.client_id = ENV['G_ID']
    client.authorization.client_secret = ENV['G_SECRET']
    client.authorization.redirect_uri = ENV['G_CALLBACK']
		client.authorization.scope = ENV['G_CONTACTS_SCOPE']
    contacts = client.discovered_api('contacts')

    p redirect_uri = client.authorization.authorization_uri
	end
end
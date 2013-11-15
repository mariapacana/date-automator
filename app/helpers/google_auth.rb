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

  def import_contacts(currentuser)
    parser = ContactParser.new(currentuser)
    parser.get_formatted_contacts
  end

end

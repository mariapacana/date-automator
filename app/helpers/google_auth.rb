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
                                  ENV['G_CAL_SCOPE']]
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

  def refresh_access_token_if_needed(currentuser)
    refresh_access_token if currentuser.google_access_token_outdated?
  end

  def refresh_access_token(currentuser)
    post_request_data(refresh_token_data(currentuser), currentuser)
  end

  def refresh_token_url
    "https://accounts.google.com/o/oauth2/token"
  end

  def refresh_token_data(currentuser)
    {refresh_token: currentuser.google_refresh_token,
     client_id: ENV['G_ID'],
     client_secret: ENV['G_SECRET'],
     grant_type: "refresh_token"}
  end

  def post_request_data(token_data, currentuser)
    uri = URI.parse(refresh_token_url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(token_data)

    Net::HTTP.start(uri.host, uri.port, 
                    :use_ssl => uri.scheme == 'https') do |http|
      response = http.request(request)
      access_token = JSON.parse(response.body)["access_token"]
      currentuser.update_google_access_token(access_token)
    end
  end

  def import_contacts(currentuser)
    parser = ContactParser.new(currentuser)
    parser.get_formatted_contacts
  end

end

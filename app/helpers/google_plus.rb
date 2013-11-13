helpers do 

  def get_people
    parsed_url = URI.parse("https://www.googleapis.com/plus/v1/people/me/people/visible?access_token=#{currentuser.google_access_token}")
    puts "url host #{parsed_url.host}, url port #{parsed_url.port}"
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(parsed_url.request_uri)
    response = http.request(request)
    puts response.body
  end


end
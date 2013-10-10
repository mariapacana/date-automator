helpers do 

	def display_oauth
		callback_url =  "http://date-automator.herokuapp.com/oauth_fromfb"

		@oauth = Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_TOKEN'], callback_url)
		@oauth.url_for_oauth_code
	end
	
end

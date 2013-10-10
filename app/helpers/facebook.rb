helpers do 

	def display_oauth
		callback_url =  "http://www.date-automator.herokuapp.com/oauth_fromfb"

		@oauth = Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET'], callback_url)
		@oauth.url_for_oauth_code
	end
	
end

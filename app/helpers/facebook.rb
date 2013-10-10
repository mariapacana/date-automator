helpers do
 
	def display_oauth
		callback_url =  "http://www.date-automator.herokuapp.com/oauth"

		@oauth = Koala::Facebook::OAuth.new(ENV['FB_ID'], ENV['FB_SECRET'], callback_url)
		puts @oauth.url_for_oauth_code
	end
	
end

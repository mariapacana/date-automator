# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'rubygems'

# Facebook integration
require 'mini_fb'
require 'koala'

# Twilio integration
require 'twilio-ruby'
require 'localtunnel'

# Google integration
require 'google/api_client'

# Authentication
require 'bcrypt'

# XML parsing
require 'nokogiri'

require 'uri'
require 'open-uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

require 'yaml'
require 'pry'

require "base64"

require 'shoulda-matchers'
require 'rspec'
require 'awesome_print'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

unless (ENV['TW_SID'] || ENV['TW_TOKEN'])
	twilio_config = YAML.load_file(APP_ROOT.join('config', 'twilio.yaml'))
	twilio_config.each do |name, setting|
	  ENV[name] = setting 
	  puts "#{name} = #{ENV[name]}"
	end
end

unless (ENV['FB_SID'] || ENV['FB_TOKEN'])
	fb_config = YAML.load_file(APP_ROOT.join('config', 'facebook.yaml'))
	fb_config.each do |name, setting|
	  ENV[name] = setting 
	  puts "#{name} = #{ENV[name]}"
	end
end

unless (ENV['G_SID'] || ENV['G_TOKEN'])
	g_config = YAML.load_file(APP_ROOT.join('config', 'google.yaml'))
	g_config.each do |name, setting|
	  ENV[name] = setting 
	  puts "#{name} = #{ENV[name]}"
	end
end
# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'mini_fb'

require 'twilio-ruby'
require 'localtunnel'

require 'google/api_client'
require 'yaml'

require 'bcrypt'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

twilio_config = YAML.load_file(APP_ROOT.join('config', 'twilio.yaml'))
p twilio_config
twilio_config.each do |name, setting|
  ENV[name] = setting 
  puts "#{name} = #{ENV[name]}"
end

# google_config = YAML.load_file(APP_ROOT.join('config', 'google.yaml'))
# google_config.each do |name, setting|
#   ENV[name] = setting 
# end

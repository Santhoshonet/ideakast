# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
#ENV['RAILS_ENV'] ||= 'development'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' #unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# Settings for rails-authorization-plugin
# http://github.com/DocSavage/rails-authorization-plugin/tree/master
AUTHORIZATION_MIXIN = "object roles"
LOGIN_REQUIRED_REDIRECTION    = { :controller => '/sessions', :action => 'new' }
PERMISSION_DENIED_REDIRECTION = { :controller => '/sessions', :action => 'new' }
STORE_LOCATION_METHOD = :store_location


COMPANY_NAME = 'ITX Solutions India Pvt Ltd'
SHORT_SITE_NAME = 'ITX'
LONG_SITE_NAME = "#{COMPANY_NAME} #{SHORT_SITE_NAME}"

PRODUCTION_HOST = 'ideakast.heroku.com'
STAGING_HOST = 'ideakast.heroku.com'

TWITTER_ENABLED = true

# Facebook support is experimental, and currently broken. We invite you to improve it!
FACEBOOK_ENABLED = true

SESSION_KEY = '_ideax_session'
SESSION_SECRET = '771febbdd045c2170c576873cbd34bc3458d5571b9d35feeafae294a389eec4e58f23f7518dfac41a9e272fffe5d88ab8ab0f523f439b71f8cd60f8b07a55616'

CONTRIBUTION_SCORES = {
  :idea    => 10,
  :comment => 2,
  :vote    => 1
}

# Get ID from http://addthis.com
ADDTHIS_ID = 'YOUR_ADDTHIS_ID'

GOOGLE_WEBMASTER_KEY = "YOUR_GOOGLE_WEBMASTER_KEY"

SQL_AUTO_IS_NULL=0

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.
  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
#  config.frameworks -=[:action_mailer]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "haml"
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem "color"
  config.gem 'facebooker' if FACEBOOK_ENABLED
  config.gem 'twitter' if TWITTER_ENABLED
  config.gem 'oauth'
  config.gem 'oauth-plugin'
  #these 3 gems (mash, httparty, ruby-hmac) are needed for twitter/oauth
  config.gem 'mash'
  config.gem 'httparty'
  config.gem 'ruby-hmac', :lib => 'hmac'
  config.gem "calendar_date_select"
  config.gem "rcov"

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  #config.action_mailer.smtp_settings = {
  #       :enable_starttls_auto => true,
  #       :address => "smtp.gmail.com",
  #       :port => 587, #465
  #       :domain => 'itxsolutionsindia.com',
  #       :user_name => 'santhosh@itxsolutionsindia.com',
  #       :password => 'password@123',
  #       :authentication => 'plain'
  #}


  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :info

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => SESSION_KEY,
    :secret      => SESSION_SECRET
  }

  
  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.active_record.observers = :user_observer, :comment_observer, :idea_observer
  
  # disable forgery proction so that facebook works (we might be able to disble this only for the facebook controller)
  # config.action_controller.allow_forgery_protection = false  
end

##
#
# facebook settings created using information from:
# http://blog.evanweaver.com/articles/2007/07/13/developing-a-facebook-app-locally/
# FACEBOOK_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/facebook.yml")[RAILS_ENV]
# if (!FACEBOOK_CONFIG.nil?)
#   # FACEBOOK_CONFIG only configured for some environments
#   FACEBOOK_CONFIG.merge!(FACEBOOK_CONFIG[ENV['USER']] || {})
# end
# 

#  http://passthehash.com/hash/2009/05/how-to-facebook-connect-your-rails-app.html
ENV['XD_RECEIVER_LOCATION'] = "/fb/connect/xd_receiver.htm"
# ENV['FACEBOOK_AUTHENTICATE_LOCATION'] = "/fb/authenticate"

#file = File.open(RAILS_ROOT + "/Config/twitter.config");



#TWITTER_CONFIG = YAML.load(file.read())[RAILS_ENV]

TWITTER_CONFIG = {"secret" => "nxcAuEdDBP3DRnCZp5ga5cdRBVos8MHJm34PiYZgLk","key" => "IyEmlK78V3jK144ZiPhw"}

  ActionMailer::Base.smtp_settings = {
         :address => 'smtp.gmail.com',
         :port => '587',
         :user_name => 'santhosh@itxsolutionsindia.com',
         :password => 'password@123',
         :authentication => :login,
         :enable_starttls_auto => true,
         :smtp => true
        # :plain, :login or :cram_md5   
  }
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Avocado::Application.initialize!

# Sendgrind Config
# ActionMailer::Base.smtp_settings = {
#     user_name: SENDGRID_CONFIG['username'],
#     password: SENDGRID_CONFIG['password'],
#     user_name: SMTP_CONFIG['usr'],
#     password: SMTP_CONFIG['pass'],
#     domain: APP_DOMAIN,
#     address: 'smtp.sendgrid.net',
#     port: 587,
#     authentication: :plain,
#     enable_starttls_auto: true
#   }

# GMAIL Config
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SMTP_CONFIG_usr'],
  :password => ENV['SMTP_CONFIG_pass'],
  :domain => ENV['APP_DOMAIN'],
  :address => 'smtp.gmail.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

ENV['APP_HOST'] = 'localhost:3000' if Rails.env.development?

ActionMailer::Base.default_url_options[:host] = ENV['APP_HOST']
require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) #if Rails.env.development?
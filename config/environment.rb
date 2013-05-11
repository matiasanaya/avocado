# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Avocado::Application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: SENDGRID_CONFIG['username'],
  password: SENDGRID_CONFIG['password'],
  domain: APP_DOMAIN,
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}

require 'bundler'
Bundler.setup

require 'rack/contrib'
require 'yaml'

require './application'

mail_smtp_settings = {
  :server => 'smtp.gmail.com',
  :domain => 'gmail.com',
  :port => 587,
  :authentication => 'plain',
  :user_name => ENV['EMAIL_USERNAME'],
  :password => ENV['EMAIL_PASSWORD']
}

use Rack::MailExceptions do |m|
  m.to ENV['MAIL_TO']
  m.subject  "{nbp-exchange} [exception] %s"
  m.smtp( mail_smtp_settings )
end

run Application

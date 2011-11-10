require 'rubygems'
require 'bundler/setup'

require 'rack/contrib'
require 'yaml'

require './application'

mail_smtp_settings = {
  :server => "smtp.sendgrid.net",
  :domain => ENV['SENDGRID_DOMAIN'],
  :authentication => 'plain',
  :user_name =>ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD']
}

use Rack::MailExceptions do |m|
  m.to ENV['MAIL_TO']
  m.subject  "{nbp-exchange} [exception] %s"
  m.smtp( mail_smtp_settings )
end

run Application

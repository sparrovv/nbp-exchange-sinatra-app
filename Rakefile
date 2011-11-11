#encoding:utf-8
require './application'
require 'nbp_exchange'
require 'date'

task :setup do
  sh "heroku create"
  sh "git push heroku master"
  sh "heroku open"
end

task :seed do
  puts "starting"
  Currency.create(:symbol => 'usd', :name => 'Dolar amerykański')
  Currency.create(:symbol => 'eur', :name => 'Euro')
  puts "end"
end

desc "Run Daily Import"
task :cron do
  puts "Running cron at #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}"
  date = Date.today
  Currency.all.each do |c|
    currency = NbpExchange::Currency.new(c.symbol)

    begin
      rate = currency.rate(date)
      c.average_rates.create(:date => date, :value => rate.average_exchange_rate)
    rescue => e
      send_email(e.inspect) unless Date.today.sunday? || Date.today.saturday?
      puts "Error for date #{date}"
      raise
    end
  end
end

desc "Import Rates Since 2011-07-02"
task :import_rates do
  symbol = ENV['symbol'] || 'usd'

  start_date = Date.parse "2011-07-02"
  end_date = Date.today

  currency = NbpExchange::Currency.new(symbol)
  c = Currency.find_by_symbol(symbol)


  (start_date..end_date).each do |d|
    puts "importing #{d}"
    begin
      rate = currency.rate(d)

      c.average_rates.create(:date => d, :value => rate.average_exchange_rate)
    rescue => e
      puts "Error for date #{d}"
      puts e.inspect
    end
  end

end

def send_email(exception)

  require 'mail'
  options = { :address              => "smtp.sendgrid.net",
              :domain               => ENV['SENDGRID_DOMAIN'],
              :user_name            => ENV['SENDGRID_USERNAME'],
              :password             => ENV['SENDGRID_PASSWORD'],
              :authentication       => 'plain'}

  Mail.defaults do
    delivery_method :smtp, options
  end

  Mail.deliver do
    from    'nbp_exchange@heroku.com'
    to      ENV['MAIL_TO'] || 'sparrovv@gmail.com'
    subject "Exception - when importing currencies"
    body "#{exception}"
  end
end

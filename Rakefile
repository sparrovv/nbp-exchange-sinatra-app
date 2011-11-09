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
  Currency.create(:symbol => 'usd', :name => 'Dolar amerykański')
  Currency.create(:symbol => 'eur', :name => 'Euro')
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
      puts "Error for date #{e}"
      puts e.inspect
    end
  end

end

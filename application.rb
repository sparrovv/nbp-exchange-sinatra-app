require 'rubygems'
require 'sinatra'
require 'mongoid'
require 'slim'
require 'json'

Dir["./models/**/*.rb"].each { |model| require model }

class Application < Sinatra::Base

  configure do
    set :root, File.dirname(__FILE__)
    set :static, true
    set :template, :slim
  end

  Mongoid.configure do |config|
    if ENV['MONGOHQ_URL']
      conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
      uri = URI.parse(ENV['MONGOHQ_URL'])
      config.master = conn.db(uri.path.gsub(/^\//, ''))
    else
      config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('nbp_currency_dev')
    end
  end

  get '/' do
    slim :index
  end

  get '/api/v1/currencies.json' do
    currencies = Currency.all
    content_type :json
    currencies.to_json
  end

  get '/api/v1/currencies/:symbol.json' do
    currency = Currency.find_by_symbol params[:symbol]
    if currency
      currency.to_json
    else
      error 404, {:error => "currency not found"}.to_json
    end

  end

  get '/api/v1/currencies/:symbol/average_rates/:date.json' do
    currency = Currency.find_by_symbol params[:symbol]
    if currency
      rate = currency.average_rates.where(:date => params[:date]).first
      if rate
        rate.to_json
      else
        error 404, {:error => "average rate not found"}.to_json
      end

    else
      error 404, {:error => "currency not found"}.to_json
    end
  end

  get '/api/v1/currencies/:symbol/average_rates/last_available/:date.json' do
    currency = Currency.find_by_symbol params[:symbol]
    if currency
      rate = currency.average_rates.find_last_available params[:date]
      if rate
        rate.to_json
      else
        error 404, {:error => "average rate not found"}.to_json
      end

    else
      error 404, {:error => "currency not found"}.to_json
    end

  end

  post '/daily_update' do

  end
end

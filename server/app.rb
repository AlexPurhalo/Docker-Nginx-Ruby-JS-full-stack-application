require 'rubygems'
require 'bundler/setup'

Bundler.require :default, (ENV['RACK_ENV'] || 'development').to_sym

DB = Sequel.connect(
  adapter:  'postgres',
  host:     ENV['DB_HOST'],
  database: ENV['POSTGRES_DB'],
  user:     ENV['POSTGRES_USER'],
  password: ENV['POSTGRES_PASSWORD']
)

Dir['./models/*.rb'].each { |file| require file }

class App < Sinatra::Base
  get '/' do
    'Welcome to Sinatra Microservice'
  end

  get '/api/v1/notes' do
    Note.all.map(&:values).to_json
  end

  post '/api/v1/notes' do
    values = JSON.parse(request.body.read)
    Note.create(values)
    Note.all.map(&:values).to_json
  end
end

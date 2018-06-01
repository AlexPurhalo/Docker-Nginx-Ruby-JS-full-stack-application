require 'rubygems'
require 'bundler/setup'

Bundler.require :default

puts "user: #{ENV['POSTGRES_USER']}, password: #{ENV['POSTGRES_PASSWORD']}"

puts ENV['DATABASE']

DB = Sequel.connect(
  adapter:  'postgres',
  host:     ENV['DB_HOST'],
  database: ENV['POSTGRES_DB'],
  user:     ENV['POSTGRES_USER'],
  password: ENV['POSTGRES_PASSWORD']
)

Dir['./models/*.rb'].each { |file| require file }

class App < Sinatra::Base
  get '/api/v1/notes' do
    Note.all.map(&:values).to_json
  end

  post '/api/v1/notes' do
    params = JSON.parse(request.body.read)

    Note.create(params)

    Note.all.map(&:values).to_json
  end
end

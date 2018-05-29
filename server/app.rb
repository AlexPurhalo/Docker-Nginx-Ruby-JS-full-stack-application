require 'rubygems'
require 'bundler/setup'

Bundler.require :default

class App < Sinatra::Base
  get '/' do
    { message: 'hello world' }.to_json
  end
end
require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'controllers/pets_controller'
require_relative 'controllers/stores_controller'

get '/' do
  erb( :homepage )
end
require_relative '../models/store.rb'
require_relative '../models/pet.rb'
require 'sinatra/contrib/all'


  #INDEX
get '/stores' do
  @stores = Store.all
  erb( :'stores/index')
end

  #NEW
get '/stores/new' do
  erb( :'stores/new')
end

  #CREATE
post '/stores' do
  @store = Store.new( params )
  @store.save
  redirect '/stores'
end

  #SHOW
get '/stores/:id' do
  @store = Store.find( :id )
  @pets = Pet.in_store( @store.id )
  # return @store.id
  erb( :'stores/show' )
end

  #EDIT
get '/stores/:id/edit' do
  @store = Store.find( params[:id] )  
  erb( :'stores/edit')
end

  #UPDATE
post '/stores/:id' do
  @store = Store.new( params )
  @store.update()
  redirect :"/stores/:id"
end

  #DELETE
post '/stores/:id/delete' do
  Store.destroy(params[:id])
  redirect :'/stores'
end
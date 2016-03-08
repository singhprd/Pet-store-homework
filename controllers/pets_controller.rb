require_relative '../models/pet.rb'
require_relative '../models/store.rb'
require 'sinatra/contrib/all'


  #INDEX
get '/pets' do
  @pets = Pet.all
  erb( :'pets/index' )
end

# NEW
get '/pets/new' do
  @stores = Store.all
  erb( :'pets/new' )
end

  #EDIT
get '/pets/:id/edit' do
  @pet = Pet.find( params[:id] )  
  @stores = Store.all()
  erb( :'pets/edit')
end

  #CREATE
post '/pets' do
  @pet = Pet.new( params )
  @pet.save
  redirect :'/pets'
end

  #SHOW
get '/pets/:id' do
  @pet = Pet.find( :id )
  store_id = @pet.store_id
  @store = Store.find( store_id )
  erb( :'pets/show' )
end


  #UPDATE
post '/pets/:id' do
  @pet = Pet.new( params )
  @pet.update()
  redirect :'/pets/:id'
end

  #DELETE
post '/pets/:id/delete' do
  Pet.destroy( params[:id] )
  redirect :'/pets'
end
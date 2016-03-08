require 'PG'

class Store

attr_reader :name, :address, :stock_type, :id


def initialize( options )
  @name = options['name']
  @address = options['address']
  @stock_type = options['stock_type']
  @id = options['id'] or nil  
end

def save()
  sql = "INSERT INTO stores 
  ( name,
    address,
    stock_type )
    VALUES
    ( '#{ @name }',
      '#{ @address}',
      '#{@stock_type}' )"
  Store.run_sql( sql )
end

def self.all
  sql = "SELECT * FROM stores ORDER BY name"
  stores = Store.run_sql( sql )
  result = stores.map { |store| Store.new( store ) }
  return result
end

def self.find( id )
  sql = "SELECT * FROM stores WHERE id = #{id}"
  result = Store.run_sql( sql )
  store = Store.new( result[0] )
  return store
end

def self.destroy( id )
  sql = "DELETE FROM stores WHERE id = '#{id}'"
  Store.run_sql( sql )
end

def update()
    sql = "UPDATE stores SET name='#{ @name }', address='#{ @address }', stock_type = '#{@stock_type}' WHERE id = #{@id}"
     return Pet.run_sql( sql )  
end


private 

def self.run_sql( sql )
  begin
    db = PG.connect( { dbname: 'pet_store', host: 'localhost' } )
    result = db.exec( sql )
    return result
  ensure
    db.close
  end
end 


end
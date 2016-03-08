require 'PG'

class Pet

attr_reader :name, :pet_type, :image, :id, :store_id

def initialize( options )
  @name = options['name']
  @pet_type = options['pet_type']
  @image = options['image']
  @id = options['id'] or nil
  @store_id = options['store_id'] or nil
end

def save()
  sql = "INSERT INTO pets 
  ( name,
    pet_type,
    image,
    store_id )
    VALUES
    ( '#{@name }',
      '#{@pet_type}',
      '#{@image}',
      '#{@store_id}' )"
  Pet.run_sql( sql )
end

def self.all
  sql = "SELECT * FROM pets ORDER BY name"
  pets = Pet.run_sql( sql )
  result = pets.map { |pet| Pet.new( pet ) }
  return result
end

def self.find( id )
 sql = "SELECT * FROM pets WHERE id = #{id}"
 result = Pet.run_sql( sql )
 pet = Pet.new( result[0] )
 return pet
end

def update()
    sql = "UPDATE pets SET name='#{ @name }', pet_type='#{ @pet_type }', image = '#{@image}', store_id = '#{@store_id}' 
    WHERE id = #{@id}"
    return Pet.run_sql( sql )  
end

def self.destroy( id )
  sql = "DELETE FROM pets WHERE id = '#{id}'"
  Pet.run_sql( sql )
end

def self.in_store( storeid )
  sql = "SELECT * FROM pets WHERE store_id = '#{storeid}'"
  pets = Pet.run_sql( sql )
  result = pets.map { |pet| Pet.new( pet ) }
  return result
end


private 

  def self.run_sql( sql )
    begin
      db = PG.connect( { dbname: 'pet_store', host: 'localhost' } )
      result = db.exec( sql )
    ensure
      db.close
    end
    return result
  end 

end
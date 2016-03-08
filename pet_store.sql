CREATE TABLE stores (
  id serial8 PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  stock_type VARCHAR(255)
);

CREATE TABLE pets (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  pet_type VARCHAR(255),
  image VARCHAR(255),
  store_id INT8 REFERENCES stores(id) 
  );
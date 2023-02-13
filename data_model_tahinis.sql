drop table if EXISTS categories cascade;
CREATE table categories (
    category_ID SERIAL PRIMARY KEY,
    category_name VARCHAR(25),
    description VARCHAR,
    picture BYTEA
);

\copy categories FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/categories.csv' DELIMITER ',' CSV HEADER;


-- ***********************************************************************************************************************************
--                                  CUSTOMERS
-- ***********************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS customers CASCADE;
-- Creating customers table --
CREATE TABLE customers (
    customer_ID VARCHAR(20) PRIMARY KEY,
    company_Name VARCHAR(150),
    contact_Name VARCHAR(200),
    contact_Title VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(50),
    region VARCHAR(50),
    postal_Code VARCHAR(50),
    country VARCHAR(20),
    phone VARCHAR(25),
    fax VARCHAR(25)
);
-- Inserting Data --
\copy customers FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/customers.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     EMPLOYEES
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS employees CASCADE;
-- Creating employees table --
CREATE TABLE employees (
    employee_ID INT PRIMARY KEY,
    last_Name VARCHAR(50),
    first_Name VARCHAR(50),
    title VARCHAR(100),
    titleOfCourtesy VARCHAR(15),
    birth_Date DATE,
    hire_Date DATE,
    address VARCHAR(150),
    city VARCHAR(20),
    region VARCHAR(20),
    postal_Code VARCHAR(20),
    country VARCHAR(20),
    home_Phone VARCHAR(25),
    extension VARCHAR(15),
    photo TEXT,
    notes VARCHAR(255),
    reports_To INT, 
    photo_Path VARCHAR(200)
   
);
-- Inserting Data --
\copy employees FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/employees.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     SHIPPERS
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS shippers CASCADE;
-- Creating shippers table --
CREATE TABLE shippers (
    shipper_ID SERIAL PRIMARY KEY,
    company_Name VARCHAR(50) NOT NULL,
    phone VARCHAR(20)
);
-- Inserting Data --
\copy shippers FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/shippers.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     ORDERS
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS orders CASCADE;
-- Creating orders table --
CREATE TABLE orders (
    order_ID SERIAL PRIMARY KEY,
    customer_ID VARCHAR(20) REFERENCES customers (customer_ID),
    employee_ID INT REFERENCES employees (employee_ID),
    order_Date DATE,
    required_Date DATE,
    shipped_Date DATE,
    ship_Via INT REFERENCES shippers (shipper_ID),
    freight FLOAT,
    ship_Name VARCHAR(50),
    ship_Address VARCHAR(50),
    ship_City VARCHAR(50),
    ship_Region VARCHAR(50),
    ship_Postal_Code VARCHAR(20),
    ship_Country VARCHAR(20)
);
-- Inserting Data --
\copy orders FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/orders.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     REGIONS
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS regions CASCADE;
-- Creating orders table --
CREATE TABLE regions (
    region_ID SERIAL PRIMARY KEY,
    region_Description VARCHAR(20)
    
);
-- Inserting Data --
\copy regions FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/regions.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     SUPPLIERS
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS suppliers CASCADE;
-- Creating orders table --
CREATE TABLE suppliers (
    supplier_ID	SERIAL PRIMARY KEY,
	company_Name VARCHAR(50),
	contact_Name VARCHAR(50),
	contact_Title VARCHAR(50),
	address	VARCHAR(50),
	city VARCHAR(20),
	region VARCHAR(255),
	postal_Code VARCHAR(20),
	country	VARCHAR(20),
	phone VARCHAR(20),
	fax	VARCHAR(20),
	home_Page VARCHAR(250)
    
);
-- Inserting Data --
\copy suppliers FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/suppliers.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     PRODUCTS
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS products CASCADE;
-- Creating orders table --
CREATE TABLE products (
    product_ID SERIAL  PRIMARY KEY,
	product_Name VARCHAR(255),
	supplier_ID SERIAL REFERENCES suppliers (supplier_ID),
	category_ID SERIAL REFERENCES categories (category_ID),
	quantity_Per_Unit VARCHAR(255),
	unit_Price DECIMAL,
	units_In_Stock INTEGER,
	units_On_Order INTEGER,
	reorder_Level INTEGER,
	discontinued BOOL
    
);
-- Inserting Data --
\copy products FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/products.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     Territories
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS territories CASCADE;
-- Creating orders table --
CREATE TABLE territories (
    territory_ID INTEGER PRIMARY KEY,
    territory_Description VARCHAR(255),	
    region_ID SERIAL REFERENCES regions (region_ID)
	    
);
-- Inserting Data --
\copy territories FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/territories.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     Employee Territories
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS employee_territories CASCADE;
-- Creating orders table --
CREATE TABLE employee_territories (
	employee_ID	INTEGER REFERENCES employees (employee_ID),
	territory_ID INTEGER REFERENCES territories (territory_ID)
	 
);
-- Inserting Data --
\copy employee_territories FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/employee_territories.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

-- *************************************************************************************************************************************
--                                     Order Details
-- *************************************************************************************************************************************
-- Drop Table if already exists --
DROP TABLE IF EXISTS order_details CASCADE;
-- Creating orders table --
CREATE TABLE order_details (
    order_ID SERIAL,
	product_ID SERIAL,
	unit_Price NUMERIC,	
	quantity INTEGER,	
	discount NUMERIC,	
	
	FOREIGN KEY (order_ID) REFERENCES orders (order_ID),
	FOREIGN KEY (product_ID) REFERENCES products (product_ID)
	 
);
-- Inserting Data --
\copy order_details FROM '/Users/mykolawauer/spiced_projects/GitHub/tahini-tensor-student-code/northwind_data_clean/data/order_details.csv' DELIMITER ',' CSV HEADER NULL 'NULL';



	


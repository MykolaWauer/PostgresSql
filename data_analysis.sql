-- Get the names and the quantities in stock for each product:

SELECT 
	product_name AS product_name
	, quantity_per_unit AS quantity	
	, units_in_stock AS units_in_stock

FROM 
 	products;

-- Get a list of current products (Product ID and name):

SELECT 
	product_id AS id
	, product_name AS product_name

FROM 
	products;

-- Get a list of the most and least expensive products (name and unit price):

SELECT 
	x.product_name
	, x.unit_price
FROM 
	products x
JOIN (
  SELECT y.product_id 
  FROM products y
  ORDER BY unit_price DESC
  LIMIT 5
) y ON x.product_id = y.product_id

UNION

SELECT 
	x.product_name
	, x.unit_price
FROM 
	products x
JOIN (
  SELECT y.product_id 
  FROM products y
  ORDER BY unit_price ASC
  LIMIT 5
) y ON x.product_id = y.product_id

ORDER BY unit_price DESC;


-- Get products that cost less than $20:

SELECT 
	product_name
	, unit_price
FROM 
	products
WHERE 
	unit_price < 20
ORDER BY 
	unit_price DESC;

-- Get products that cost between $15 and $25:

SELECT 
	product_name
	, unit_price
FROM 
	products
WHERE 
	unit_price >= 15 AND unit_price <= 25
ORDER BY 
	unit_price DESC

-- Get products above average price:

WITH avg_price AS (
  SELECT 
  	AVG(unit_price) AS avg_price
  FROM 
  	products
)

SELECT 
	product_name
	, unit_price
FROM 
	products p
JOIN 
	avg_price a ON p.unit_price > a.avg_price
ORDER BY 
	unit_price DESC;
	
-- Find the ten most expensive products:

SELECT 
	product_Name
	, unit_price
FROM 
	products
ORDER BY 
	unit_price DESC
LIMIT 10;

-- Get a list of discontinued products (Product ID and name):

SELECT 
	product_id
	, product_name
FROM 
	products
WHERE 
	discontinued = TRUE;
	
-- Count current and discontinued products:

SELECT
	CASE 
		WHEN discontinued = FALSE THEN 'current' 
	ELSE 'discontinued' 
	END AS Product_Status,
  	COUNT(*) AS ProductCount
FROM 
	products
GROUP BY 
	Product_Status;
	
-- Find products with less units in stock than the quantity on order:

SELECT 
	product_id
	, product_name
	, units_in_stock
	, units_on_order
FROM 
	products
WHERE 
	units_in_stock < units_on_order;
	
-- Find the customer who had the highest order amount:

WITH raw_data AS (
	SELECT 
		DISTINCT o.customer_id AS customer_id
		, o.order_id
		, od.quantity
	FROM 
		orders o
	LEFT JOIN 
		order_details od ON o.order_id = od.order_id
	ORDER BY quantity DESC
	)
	
SELECT
	DISTINCT rd.customer_id AS customer_id,
	c.company_name AS customer_name,
	SUM(quantity) AS quantity

FROM 
	raw_data rd
LEFT JOIN 
	customers c ON rd.customer_id = c.customer_id
GROUP BY 
	rd.customer_id
	, customer_name
ORDER BY 
	quantity DESC
LIMIT 1;

-- Get orders for a given employee and the according customer:

WITH raw_data AS (
	SELECT 
		DISTINCT o.customer_id AS customer_id
		, o.order_id AS order_id
		, o.employee_id AS employee_id
		, c.company_name AS customer_name
	FROM 
		orders o
	LEFT JOIN 
		customers c ON o.customer_id = c.customer_id
		)
SELECT
	rd.employee_id AS employee_id
	, CONCAT(c.titleofcourtesy, ' ', c.first_name, ' ', c.last_name) AS name --concat  
	, rd.customer_id AS customer_id
	, rd.customer_name AS customer_name
	, rd.order_id AS order_id
	
FROM 
	raw_data rd
LEFT JOIN 
	employees c ON rd.employee_id = c.employee_id
ORDER BY 
	rd.employee_id ASC;
	

-- Find the hiring age of each employee:

SELECT 
	employee_id
	, CONCAT(titleofcourtesy, ' ', first_name, ' ', last_name) AS name
	, EXTRACT(YEAR FROM hire_Date) - EXTRACT(YEAR FROM birth_Date) AS hire_age

	
FROM 
	employees
ORDER BY hire_age DESC;

-- What is the total revenue delivered in each country? Named Query:
CREATE VIEW TotalRevenueByCountry AS
SELECT 
  c.country AS country,
  SUM(od.unit_price * od.quantity *(1-discount)) AS revenue
FROM 
  order_details od
  INNER JOIN orders o ON od.order_id = o.order_id
  INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 
  c.country
ORDER BY 
  revenue DESC

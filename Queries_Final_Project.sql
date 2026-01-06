/*=====================================================================================
								Final Project - Food Delivery Database
										Database: SQLite
										 Tool: DBeaver
	====================================================================================*/


--------Enable foreign key enforcement in SQLite --------

PRAGMA foreing_key = ON;


--------Creation of database tables  --------


/* =========================================================
   TABLE: customers
   Purpose: Stores customer profile information
   ========================================================= */


CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    phone TEXT,
    city TEXT,
    signup_date DATE
);


/* =========================================================
   TABLE: restaurants
   Purpose: Stores restaurant information
   ========================================================= */

CREATE TABLE restaurants (
    restaurant_id INTEGER PRIMARY KEY,
    restaurant_name TEXT,
    cuisine_type TEXT,
    city TEXT,
    is_active INTEGER
);


/* =========================================================
   TABLE: menu_items
   Purpose: Stores menu items offered by restaurants
   Relationship:
     - restaurant_id → restaurants
   ========================================================= */

CREATE TABLE menu_items (
    menu_item_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER,
    item_name TEXT,
    category TEXT,
    price REAL,
    is_available INTEGER,
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

/* =========================================================
   TABLE: drivers
   Purpose: Stores delivery driver information
   ========================================================= */

CREATE TABLE drivers (
    driver_id INTEGER PRIMARY KEY,
    driver_name TEXT,
    vehicle_type TEXT,
    city TEXT,
    is_active INTEGER
);


/* =========================================================
   TABLE: orders
   Purpose: Stores customer orders
   Relationships:
     - customer_id → customers
     - restaurant_id → restaurants
   ========================================================= */

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    restaurant_id INTEGER,
    order_ts DATETIME,
    status TEXT,
    subtotal REAL,
    tax REAL,
    delivery_fee REAL,
    tip REAL,
    total REAL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);


/* =========================================================
   TABLE: order_items
   Purpose: Junction table between orders and menu_items
   ========================================================= */

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    menu_item_id INTEGER,
    quantity INTEGER,
    unit_price REAL,
    line_total REAL,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (menu_item_id)
        REFERENCES menu_items(menu_item_id)
);


/* =========================================================
   TABLE: deliveries
   Purpose: Stores delivery execution details
   Relationships:
     - order_id → orders
     - driver_id → drivers
   ========================================================= */

CREATE TABLE deliveries (
    delivery_id INTEGER PRIMARY KEY,
    order_id INTEGER UNIQUE,
    driver_id INTEGER,
    pickup_ts DATETIME,
    dropoff_ts DATETIME,
    distance_km REAL,
    delivery_status TEXT,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (driver_id)
        REFERENCES drivers(driver_id)
);


-------- List all tables in the SQLite database --------

SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;


-------- Enable foreign key constraints in SQLite --------

PRAGMA foreing_keys = ON;


-------- Check foreign key constraints for each table --------

PRAGMA foreign_key_list(deliveries);
PRAGMA foreign_key_list(orders);
PRAGMA foreign_key_list(order_items);
PRAGMA foreign_key_list(menu_items);


-------- Data import validation --------
 

SELECT 'customers'     AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'restaurants',  COUNT(*) FROM restaurants
UNION ALL
SELECT 'drivers',      COUNT(*) FROM drivers
UNION ALL
SELECT 'orders',       COUNT(*) FROM orders
UNION ALL
SELECT 'menu_items',   COUNT(*) FROM menu_items
UNION ALL
SELECT 'order_items',  COUNT(*) FROM order_items
UNION ALL
SELECT 'deliveries',   COUNT(*) FROM deliveries;



------------------------------                       QUERIES 				-----------------------------------------------------


-------- 1. Identify restaurants with the highest number of orders and total revenue --------


SELECT
    r.restaurant_id,
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total), 2) AS total_revenue,
    ROUND(AVG(o.total), 2) AS avg_order_value
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
WHERE o.total > 0
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC, total_orders DESC
LIMIT 10;


-------- 2. Identify customers with the highest total spending and order frequency --------


SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total), 2) AS total_spent,
    ROUND(AVG(o.total), 2) AS avg_order_value
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC, total_orders DESC
LIMIT 10;

-------- 3. Top 10 most ordered menu items --------


SELECT
    r.cuisine_type,
    mi.category,
    mi.item_name,
    COUNT(*) AS times_ordered
FROM order_items oi
JOIN menu_items mi
    ON oi.menu_item_id = mi.menu_item_id
JOIN restaurants r
    ON mi.restaurant_id = r.restaurant_id
GROUP BY
    r.cuisine_type,
    mi.category,
    mi.item_name
ORDER BY times_ordered DESC
LIMIT 10;


-------- 4. Driver Performance Based on Delivery Volume, Time, and Distance --------


SELECT
    d.driver_name,
    COUNT(del.delivery_id) AS total_deliveries,
    ROUND(
        AVG(
            (julianday(del.dropoff_ts) - julianday(del.pickup_ts)) * 24 * 60
        ), 2
    ) AS avg_delivery_minutes,
    ROUND(AVG(del.distance_km), 2) AS avg_distance_km
FROM deliveries del
JOIN drivers d
    ON del.driver_id = d.driver_id
GROUP BY d.driver_id, d.driver_name
ORDER BY total_deliveries DESC;


-------- 5. Which cuisine types generate the highest order volume across the platform? --------


SELECT
    r.cuisine_type,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
GROUP BY r.cuisine_type
ORDER BY total_orders DESC;


------6. How frequently do customers place repeat orders over time? ------

SELECT
    r.restaurant_name,
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
GROUP BY
    r.restaurant_name,
    c.customer_id,
    customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;


------7. What is the average order value per restaurant? ------


SELECT
    r.restaurant_name,
    ROUND(AVG(o.total), 2) AS avg_order_value,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY avg_order_value DESC;


-------- 8. Which restaurants have the highest number of repeat customers? ------

WITH customer_orders AS (
    SELECT
        restaurant_id,
        customer_id,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY restaurant_id, customer_id
)
SELECT
    r.restaurant_name,
    COUNT(*) AS repeat_customers
FROM customer_orders co
JOIN restaurants r
    ON r.restaurant_id = co.restaurant_id
WHERE co.total_orders >= 2
GROUP BY r.restaurant_name
ORDER BY repeat_customers DESC;


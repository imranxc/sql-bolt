-- Online Compiler: https://dbfiddle.uk/5A9fDGNy

-- check version
select version();

-- import `schemas/create-database.sql` file and execute
show databases;
show tables;

-- ================== select statement ==================

use sql_store;

-- select all customers
select "Hello, World";
select * from customers;
select * from customers order by points desc;

-- select a specific customer
select * from customers where customer_id = 2;

-- select multiple columns
select 
    first_name, 
    last_name, 
    points, 
    (points + 10) * 100 as discount_factor
from customers;

-- select all customer's state
select state from customers;

-- update state for `id = 1` on purpose
update customers set state = "VA" where customer_id = 1;

-- select without duplicates
select distinct state from customers;

-- sort customers by first_name
-- default sort is id
select * from customers order by first_name;
select * from customers order by first_name desc;

-- Exercise
-- return all the products
    -- name
    -- unit_price
    -- new_price (unit_price * 1.1)
select 
    name, 
    unit_price, 
    (unit_price * 1.1) as new_price 
from products;

-- ================== where clause ==================

select * from customers where points > 3000;
select * from customers where state = "VA";

-- select all customers except Virginia
select * from customers where state != "VA";
select * from customers where state <> "va"; -- case insensitive
select * from customers where state not like "%VA%";

-- customers born after 1st January of 1990
select * from customers where birth_date > "1990-01-01";

-- Exercise
-- get the orders placed in 2017
select * from orders where order_date > "2017-01-01" and order_date < "2017-12-31";
select * from orders where order_date between "2017-01-01" and "2017-12-31";
select * from orders where year(order_date) = "2017";

-- multiple conditions (both return same result)
select * from customers 
where birth_date <= "1990-01-01" and points <= 1000;

select * from customers 
where not (birth_date > "1990-01-01" or points > 1000);

-- Exercise
-- from the `order_items` table, get the items
	-- for order #6 where total price is > 30
select * from order_items 
where order_id = 6 and (quantity * unit_price) > 30 as unit_price;

-- ================== IN operator ==================

select * from customers where state = "VA" or state = "GA" or state = "FL";
select * from customers where state in ("VA", "GA", "FL");

select * from customers where state not in ("VA", "GA", "FL");

-- Exercise
-- return products with
	-- quantity in stock equal to 49, 38, 72
select * from products 
where quantity_in_stock in (49, 72, 38);

-- ================== between clause ==================

select * from customers 
where points >= 1000 and points <= 3000; 

select * from customers where points between 1000 and 3000; -- inclusive

-- Exercise
-- return customers born between 01/01/1990 and 01/01/2000
select * from customers 
where birth_date between "1990-01-01" and "2000-01-01";


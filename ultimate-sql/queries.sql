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

-- ================== LIKE operator ===================

-- `_` single character
-- `%` any number of characters

-- any last name that starts with b and followed by any number of characters.
select * from customers where last_name like "b%"; -- starts with b
select * from customers where last_name like "%b%"; -- b can be anywhere

select * from customers where last_name like "%y"; -- ends with y

-- exact 2 characters long name 1st char can be anything but last char should be y
select * from customers where last_name like "_y"; 

-- Exercise
-- get the customers whose
-- address contain trail or avenue
select * from customers where address like "%trail%" or address like "%avenue%";
select * from customers where address regexp "trail|avenue";
-- phone number's last digit is 9
select * from customers where phone like "%9";
select * from customers where phone regexp "9$";

-- ================== regexp ==================

-- ^ starts with
-- $ ends with
-- | logical OR
-- [] match any single character
-- [a-f] a to f any character

select * from customers where phone regexp "^9"; -- starts with 9
select * from customers where phone regexp "9$"; -- ends with 9

-- match any last_name that contains any of the specified substrings.
select * from customers where last_name regexp "field|mac|rose"; 

-- match any last_name that either start with 'Field' or include the substrings 'Mac' or 'Rose'.
select * from customers where last_name regexp "^field|mac|rose"; 

-- match any last_name that has "g|i|m" followed by "e"
select * from customers where last_name regexp "[gim]e";

-- Exercises
-- get the customers whose  
-- first names are `elka` or `ambur`
select * from customers where first_name in ("elka", "ambur");
select * from customers where first_name regexp "elka|ambur";
-- last name ends with `ey` or `on`
select * from customers where last_name regexp "ey$|on$";
select * from customers where last_name like "%ey" or last_name like "%on";
-- last name starts with `my` or contains `se`
select * from customers where last_name like "my%" or last_name like "%se%";
select * from customers where last_name regexp "^my|se";
-- last name contains `b` followed by `r` or `u`
select * from customers where last_name like "%br%" or last_name like "%bu%";
select * from customers where last_name regexp "br|bu";
select * from customers where last_name regexp "b[ru]";

-- ================== IS Operator ==================

select * from customers where phone is null;
select * from customers where phone is not null;

-- Exercise
-- get the orders that are not shipped yet
select * from orders where shipper_id is null;

-- ================== order by clause ==================

select * from customers order by first_name;
select * from customers order by last_name desc;

-- sort first by `first_name` in ascending order, then by `last_name` in descending order within each `first_name` group.
select * from customers order by first_name, last_name desc;

-- sort first by `first_name` in ascending order, then by `last_name` in ascending order within each `first_name` group.
select * from customers order by first_name, last_name;

-- sort records by alias [valid only MySQL]
select first_name, last_name, (10+1) as points from customers order by points;

-- Exercise
-- sort records for order 2 by total price in descending order
select 
    *, quantity*unit_price as total_price
from order_items 
where order_id = 2 
order by total_price desc;

-- limit
select * from order_items limit 3 offset 3; -- skip first 3s, returns 4,5,6

select * from customers limit 3 offset 6; -- skip first 6s, returns 7, 8, 9
select * from customers limit 6 offset 3; -- skip first 3s, returns 4, 5, 6, 7, 8, 9
-- shortcut
select * from customers limit 6, 3; -- offset, limit

-- Exercise
-- get the top 3 loyal customers
select * from customers order by points desc limit 3;

-- ================== JOIN ==================

select * from orders 
join customers 
on orders.customer_id = customers.customer_id;

select 
    o.order_id, o.customer_id, c.first_name, c.last_name 
from orders as o 
join customers as c 
on o.customer_id = c.customer_id;

-- Exercise
-- JOIN order_items with products table
select 
    oi.order_id, p.name, oi.quantity, oi.unit_price 
from order_items as oi 
join products as p 
on oi.product_id=p.product_id;

-- JOIN from another database table
select 
    p.name, oi.unit_price 
from order_items as oi 
join sql_inventory.products as p 
on p.product_id = oi.product_id;

-- self join
use sql_hr;

select
    e.employee_id, e.first_name, m.first_name as manager
from employees as e 
join employees as m 
on e.reports_to=m.employee_id;

-- JOIN multiple tables
use sql_store;

select
    o.order_id, o.order_date, c.first_name, c.last_name, os.name as status
from orders as o 
join customers as c 
on o.customer_id=c.customer_id
join order_statuses as os 
on o.status=os.order_status_id;

-- Exercise
use sql_invoicing;

select 
    p.payment_id, c.name, p.invoice_id, p.date, p.amount, pm.name
from clients as c
join payments as p
on c.client_id=p.client_id
join payment_methods as pm
on pm.payment_method_id=p.payment_method;

-- compound join
-- composite pk contains more than one column 
use sql_store;

select
    *
from order_items as oi 
join order_item_notes as oin
on oi.order_id=oin.order_id and oi.product_id=oin.product_id;

-- implicit join (bad practice)
select 
    o.order_id, o.customer_id, c.first_name, c.last_name 
from orders as o, customers as c 
where o.customer_id = c.customer_id;

-- explicit join
select 
    o.order_id, o.customer_id, c.first_name, c.last_name 
from orders as o 
join customers as c 
using (customer_id); -- on o.customer_id = c.customer_id

-- outer join (left/right)
select 
    c.first_name, c.customer_id, o.order_id 
from customers as c 
left join orders as o 
using (customer_id);

select 
    c.first_name, c.customer_id, o.order_id 
from orders as o  
right join customers as c
using (customer_id);

-- Exercise
select 
    p.product_id, p.name, oi.quantity
from products as p 
left join order_items as oi
using (product_id);

-- join multiple tables
select 
    c.first_name, c.customer_id, o.order_id, sh.name as shipper
from customers as c 
left join orders as o
using (customer_id)
left join shippers as sh
using (shipper_id);

-- Exercise
select 
    o.order_date, 
    o.order_id, 
    c.first_name as customer, 
    sh.name as shipper, 
    oi.name as status
from orders as o
left join customers as c
using (customer_id)
left join shippers as sh
using (shipper_id)
join order_statuses as oi
on o.status=oi.order_status_id;

-- self outer join
use sql_hr;

select
    e.employee_id, e.first_name, m.first_name as manager
from employees as e 
left join employees as m 
on e.reports_to=m.employee_id;

-- natural join joins 2 tables based on the common column name [same name]
use sql_store;

select 
    o.order_id, c.first_name 
from orders as o 
natural join customers as c;

-- cross join (every record from left table joins with every record from right table)
select 
    c.first_name, p.name 
from customers as c 
cross join products as p 
order by c.first_name;

-- implicit
select 
    c.first_name, p.name 
from customers as c, products as p
order by c.first_name;

-- Exercise
-- Do a cross join between shippers and products
-- using the implicit syntax and then using the explicit syntax
select
    sh.name as shipper, p.name as product
from shippers as sh, products as p
order by p.name;

select
    sh.name as shipper, p.name as product
from shippers as sh 
cross join products as p
order by p.name;

-- union
select 
    o.order_id, o.order_date, "Active" as status 
from orders as o
where order_date >= "2019-01-01"
    union -- combine records from multiple queries
select 
    o.order_id, o.order_date, "Archive" as status 
from orders as o
where order_date < "2019-01-01";

-- from multiple table
select first_name from customers 
    union 
select name from shippers;

-- produce error [number of columns of each query should be equal]
select first_name, last_name from customers 
    union 
select name from shippers;

-- Exercise
select
    c.customer_id, c.first_name, c.points, "Gold" as type
from customers as c
where c.points > 3000
    union 
select
    c.customer_id, c.first_name, c.points, "Silver" as type
from customers as c
where c.points <= 3000 and c.points >= 2000
    union 
select
    c.customer_id, c.first_name, c.points, "Bronze" as type
from customers as c
where c.points < 2000
order by first_name;

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

-- ================== Insert data ==================

insert into customers values (default, "John", "Snow", "1991-01-01", null, "13th Street. 47 W 13th St", "Queens", "NY", 0);

insert into shippers (name) values 
    ("Shipper 1"),
    ("Shipper 2"),
    ("Shipper 3");

-- Exercise
-- Insert 3 rows in the product table
insert into products (name, quantity_in_stock, unit_price) values
    ("Wireless Mouse", 150, 24.99),
    ("Bluetooth Headphones", 75, 59.99),
    ("USB-C Charging Cable", 200, 9.99);

update products set name = "Wireless Mouse and Keyboard" where product_id = 11;

-- Insert data into multiple table (parent/child)
insert into orders (customer_id, order_date, status) values 
	(10, "1990-02-01", 1);
insert into order_items (order_id, product_id, quantity, unit_price) values 
	(last_insert_id(), 1, 2, 2.95)
    (last_insert_id(), 2, 3, 3.95);

-- copy data from one table to another
-- NOTE: doesn't mark order_id as pk, no auto_increment
create table order_archived as select * from orders;
desc order_archived;

-- copy specific data by using sub query
truncate table order_archived;

insert into order_archived
select * from orders where order_date > "2018-01-01";

-- Exercise
use sql_invoicing;

create table if not exists invoice_archived as
    select i.invoice_id, i.number, c.name, i.invoice_total, i.payment_total, i.invoice_date, i.due_date, i.payment_date
from invoices as i
join clients as c using (client_id) 
where i.payment_date is not null;

select * from invoice_archived;

use sql_store;

-- Exercise
-- write a sql statement to
    -- give any customers born before 1990
    -- 50 extra points
update customers set points = (points + 50) where year(birth_date) < 1990;

-- Exercise
-- update customers comment as "Gold Customer" whose points are greater than 3000
update orders set comments = "Gold Customer" 
where customer_id in (
    select customer_id from customers 
    where points > 3000
);

use sql_invoicing;

-- delete a record
delete from invoices where invoice_id = 1;

-- ================== aggregate functions ==================

-- To count all values, including nulls, use `count(*)` instead of `count(column)`, which only counts non-null values.
use sql_invoicing;

select
    max(invoice_total) as highest,
    min(invoice_total) as lowest,
    avg(invoice_total) as average,
    sum(invoice_total) as total,
    count(*) as total_invoices
from invoices;

-- Exercise
select
    "First half of 2019" as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total - payment_total) as what_to_expect
from invoices 
where invoice_date between "2019-01-01" and "2019-06-30"
    union 
select
    "Second half of 2019" as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total - payment_total) as what_to_expect
from invoices 
where invoice_date between "2019-07-01" and "2019-12-31"
    union 
select
    "Total" as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total - payment_total) as what_to_expect
from invoices 
where invoice_date between "2019-01-01" and "2019-12-31";

-- Group by clause
select 
    sum(invoice_total) as total_sales,
    client_id
from invoices 
group by client_id
order by total_sales desc;

-- Exercise
select 
    p.date,
    pm.name as payment_method_name,
    sum(p.amount) as total_payments
from payments as p 
join payment_methods as pm 
    on p.payment_method = pm.payment_method_id
group by p.date, payment_method_name
order by p.date;

-- having clause

-- `where` clause filter the data before `group by` clause, 
-- `having` clause filter the data after `group by` clause.
    -- allowed to use alias names
use sql_invoicing;

select 
    client_id, 
    sum(invoice_total) as total_sales,
    count(*) as number_of_invoices
from invoices
group by client_id
having total_sales > 500 and number_of_invoices > 5;

-- Exercise
-- Get the customers
    -- located in Virginia
    -- who have spent more than $100
use sql_store;

select
    c.customer_id,
    c.first_name,
    c.last_name,
    sum(oi.quantity * oi.unit_price) as total_sales
from customers as c 
join orders as o using (customer_id)
join order_items as oi using (order_id)
where state = "VA"
group by
    c.customer_id,
    c.first_name,
    c.last_name
having total_sales > 100;

-- Rollup (available only MySQL)
-- it generates subtotal and grand total rows, which can introduce NULL values in grouped columns
select
    client_id,
    sum(invoice_total) as total_sales
from invoices
group by client_id with rollup;

-- Exercise
-- with rollup, you can't use alias name in group by clause
select
    name as payment_method,
    sum(amount) as total
from payments join payment_methods
on payment_method = payment_method_id
group by name with rollup;

-- ================== Subqueries ==================

-- find all products that are more expensive than lettuce (id=3)
use sql_store;

select * from products
where unit_price > (
    select unit_price 
    from products 
    where product_id = 3
);

-- Exercise
-- in sql_hr database, find all employees who earn more than average
use sql_hr;

select * from employees
where salary > (
    select avg(salary)
    from employees
);

-- find the products that never been ordered
use sql_store;

select * from products 
where product_id not in (
    select distinct product_id
    from order_items
);

-- Exercise
-- find clients without invoices
use sql_invoicing;

select * from clients 
where client_id not in (
    select distinct client_id 
    from invoices
);

-- solved above problem using left join
select clients.* from clients 
left join invoices 
using (client_id)
where invoice_id is null;

-- find customers who have ordered lettuce (id=3)
-- select customer_id, first_name, last_name
use sql_store;

select 
    c.customer_id, c.first_name, c.last_name 
from customers as c
where c.customer_id in (
    select 
        o.customer_id 
    from order_items as oi 
    join orders as o 
    using (order_id) 
    where product_id=3
);

-- solved above problem using join
select 
    distinct c.customer_id, c.first_name, c.last_name 
from customers as c 
join orders as o 
using (customer_id) 
join order_items as oi 
using (order_id)
where oi.product_id=3;

-- Select invoices larger than all invoices of client 3
use sql_invoicing;

select * from invoices 
where invoice_total > (
    select max(invoice_total) 
    from invoices 
    where client_id=3
);

-- solved above problem using `ALL` keyword
-- all is used to compare a value against all values returned by a subquery
select * from invoices 
where invoice_total > all (
    select invoice_total 
    from invoices 
    where client_id=3
);

-- select clients with at least 2 invoices
use sql_store;

select * from clients 
where client_id in (
    select client_id
    from invoices 
    group by client_id 
    having count(*) >= 2
);

-- solved above problem using `ANY` Keyword
select * from clients 
where client_id = any (
    select client_id 
    from invoices 
    group by client_id 
    having count(*) >= 2
);

-- co-related subquery
    -- https://youtu.be/0d419Vo2Po4 [co related subquery]

-- select employees whose salary is above the avg in their office

-- pseudocode of the problem
    -- for each employee
    -- calculate the avg salary for employee.office
    -- return the employee if salary > avg
use sql_hr;

select *
from employees as e 
where salary > (
    select avg(salary)
    from employees
    where office_id = e.office_id
);

-- select clients that have invoices
use sql_invoicing;

select * from clients
where client_id in (
    select distinct client_id
    from invoices
);

-- solved above problem using join
select distinct clients.* from clients
join invoices using (client_id)

-- solved above problem using `exists` operator
select * from clients
where exists (
    select client_id 
    from invoices as i
    where i.client_id = client_id
);

-- find the products that never been ordered
use sql_store;

select * from products as p 
where not exists (
    select product_id 
    from order_items 
    where product_id=p.product_id
);

-- subqueries in select clause
select invoice_id, invoice_total, 
    (select avg(invoice_total) 
        from invoices
    ) as invoice_average,
    invoice_total - (select invoice_average) as difference
from invoices;

-- ================== built in functions ==================

-- Numeric functions
-- https://dev.mysql.com/doc/refman/8.4/en/numeric-functions.html

select rand(); -- random float value between 0 and 1

select round(5.23); -- 5
select round(5.2385, 2); -- 5.24

select abs(-1.23); -- 1.23

select ceiling(5.60); -- 6 [smallest integer >= current number]
select floor(5.24); -- 5

select truncate(5.9875, 3); -- 5.987

-- String functions
-- https://dev.mysql.com/doc/refman/8.4/en/string-functions.html

select length("Sky"); -- 3

select upper("sky"); -- SKY

select lower("SKY"); -- sky

select left("Kindergarten", 4); -- Kind

select right("Kindergarten", 6); -- garten

select substring("Kindergarten", 1, 5); -- Kinde | substring(string, start, length)
select substring("Kindergarten", 1); -- Kindergarten
select substring("Kindergarten", 50, 5); -- null

select locate("rG", "Kindergarten"); -- 6 | return 1st position of the character, case insensitive
select locate("X", "Kindergarten"); -- 0

select replace("Kindergarten", "garten", "garden"); -- Kindergarden | replace(string, replaceValue, newValue)

select concat("John", " ", "Doe"); -- John Doe

use sql_store;

select concat(first_name, " ", last_name) as full_name
from customers order by first_name;

-- Date function
-- https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html

select now(); -- return date & time
select curdate(); -- 2025-03-08
select curtime(); -- server's local time
select utc_time(); -- GMT time

select year(now()); -- 2025
select month(now()); -- 03
select date(now()); -- 2025-03-08

select hour(now());
select minute(now());
select second(now());

select dayname(now()); -- Saturday
select monthname(now()); -- March

select extract(month from now()); -- 3
select extract(hour from now()); 

-- Exercise
-- remove the hard-coded year
use sql_store;

select *
from orders 
where order_date >= "2019-01-01";

select *
from orders
where year(order_date) >= year(now());

-- Date formatting
-- https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html#function_date-format
select date_format(now(), "%M %d %Y"); -- March 08 2025

-- Time formatting
-- https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html#function_time-format
select time_format(now(), "%H:%i %p");

-- add a date
select date_add(now(), interval 1 year); -- 2026-03-08 05:19:47
select date_add(date(now()), interval 2 year); -- 2027-03-08

-- subtract a date
select date_add(now(), interval -1 year); -- 2020-03-08 05:20:38
select date_sub(now(), interval 1 year); -- 2020-03-08 05:21:13

select datediff("2025-03-10", "2025-03-10") as diff; -- 2
select datediff('2025-03-08', "2025-03-10") as diff; -- 2

select time_to_sec("09:00"); -- 32400 (since midnight)

-- Other functions
use sql_store;

select 
    order_id, 
    ifnull(shipper_id, "Not Assigned") as shipper
from orders;

-- if shipper_id is null then go to comments, if comments is null put not assigned
-- it takes N number of parameters
select 
    order_id, 
    coalesce(shipper_id, comments, "Not Assigned") as shipper
from orders;

-- Exercise
-- Mark customer phone number as Unknown if it is null
select
    concat(first_name, " ", last_name) as customer,
    ifnull(phone, "Unknown") as phone
from customers;

-- if function (expression, value, elseValue)
select
    order_id,
    order_date,
    if ((year(order_date) = "2019"), "Active", "Archive") as order_status
from orders;

-- Exercise
-- How many times each product has been ordered
select 
    product_id, 
    name, 
    count(product_id) as orders,
    if((count(product_id) > 1), "Many times", "Once") as frequency
from products
join order_items
using (product_id)
group by product_id, name;

-- case operator
select 
	order_id,
	case 
		when year(order_date) = year(now()) then "Active"
		when year(order_date) = year(now()) - 1 then "Last year"
		when year(order_date) < year(now()) -1 then "Archived"
        else "Future"
	end as category
from orders;

-- Exercise
select
    concat(first_name, " ", last_name) as customer,
    points, 
    case 
        when points > 3000 then "Gold"
        when points between 2000 and 3000 then "Silver"
        else "Bronze"
    end as category
from customers
order by points desc;

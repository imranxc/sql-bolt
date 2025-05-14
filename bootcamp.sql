-- Online Compiler: https://dbfiddle.uk/Fkz6ZZ6R
-- YouTube Playlist: https://www.youtube.com/playlist?list=PLcz9-JSejut-noXS7zEyDx34IJ46zGJaj

-- check MySQL version
select version();

-- see which database I'm currently work upon
select database();

-- create a new database
create database if not exists techwithpriya;
use techwithpriya;

select database(); -- techwithpriya

-- display all available tables inside a particular database
show tables;

-- employees table
create table employees(
    id int auto_increment primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    age int not null,
    salary int not null,
    location varchar(500) not null
);

-- description of the table
desc employees;

-- delete/drop a table
drop table employees;

-- insert data 
insert into employees(first_name, last_name, age, salary, location) values
    ('John', 'Doe', 29, 55000, 'New York'),
    ('Emily', 'Smith', 34, 62000, 'San Francisco'),
    ('Michael', 'Johnson', 41, 72000, 'Chicago'),
    ('Sophia', 'Brown', 27, 49000, 'Austin'),
    ('Daniel', 'Williams', 38, 58000, 'Los Angeles'),
    ('Olivia', 'Jones', 30, 60000, 'Seattle'),
    ('James', 'Davis', 45, 75000, 'Boston'),
    ('Isabella', 'Miller', 25, 47000, 'Denver'),
    ('Ethan', 'Garcia', 32, 65000, 'Miami'),
    ('Ava', 'Martinez', 28, 53000, 'Atlanta');

-- queries
select * from employees;

-- find employees first and last name
select first_name, last_name from employees;

-- find 3 max salary employees
select * from employees order by salary desc limit 3;

-- update a record
update employees set age=29 where last_name="Martinez";

-- delete a record
delete from employees where id=10;

-- What is DDL
    -- Data definition language
    -- drop, alter, and add commands
-- What is DML
    -- Data manipulation language
    -- update, delete, insert commands

-- update is used to change the record/row inside a table
-- alter is used to change the schema of the table

-- modify the schema
alter table employees modify first_name varchar(100);

-- add a new column
alter table employees add position varchar(50);

-- delete a column
alter table employees drop column position;

-- count all employees
select count(*) as total_employees from employees;

-- max salary 
select max(salary) as highest_salary from employees;

-- min salary
select min(salary) as lowest_salary from employees;

-- courses table
create table if not exists courses(
    id int auto_increment primary key,
    name varchar(50) not null,
    duration varchar(20) not null,
    fee int not null
);

-- rename a column
alter table courses change fee fees int not null;

-- source of joining table
create table if not exists sourceOfJoining(
    id int auto_increment primary key,
    title varchar(50) not null
);

-- students table
create table students(
    id int auto_increment primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    phone varchar(20) unique not null,
    email varchar(50) unique not null,
    enroll_date timestamp default current_timestamp,
    course int not null,
    experience int default 0.0,
    company varchar(50) default 'student',
    source_of_join int not null,
    location varchar(50) not null,

    foreign key (course) references courses(id),
    foreign key (source_of_join) references sourceOfJoining(id)
);

-- modify a column
alter table students modify experience decimal(10, 2);

show tables; -- courses, employees, students, sourceOfJoining

-- insert records
insert into courses (name, duration, fees) values 
    ('Introduction to Programming', '3 months', 299.99),
    ('Data Science Bootcamp', '6 months', 499.99),
    ('Web Development Fundamentals', '4 months', 399.99),
    ('Machine Learning Essentials', '5 months', 449.99),
    ('Advanced JavaScript', '2 months', 199.99),
    ('UX/UI Design Basics', '3 months', 279.99),
    ('Digital Marketing Strategy', '4 months', 359.99),
    ('Cybersecurity Fundamentals', '6 months', 539.99),
    ('Cloud Computing with AWS', '5 months', 479.99),
    ('Full Stack Development', '6 months', 599.99);

insert into sourceOfJoining (title) values 
    ('Facebook'),
    ('Twitter'),
    ('Instagram'),
    ('LinkedIn'),
    ('YouTube'),
    ('Reddit'),
    ('WhatsApp'),
    ('TikTok'),
    ('Snapchat'),
    ('Pinterest');

insert into students (first_name, last_name, phone, email, course, experience, company, source_of_join, location) values
    ('John', 'Doe', '123-456-7890', 'john.doe@example.com', 1, 2.5, 'TechCorp', 1, 'New York'),
    ('Jane', 'Smith', '234-567-8901', 'jane.smith@example.com', 2, 3.0, 'DevSolutions', 2, 'San Francisco'),
    ('Alice', 'Johnson', '345-678-9012', 'alice.johnson@example.com', 3, 1.0, 'WebWorks', 3, 'Los Angeles'),
    ('Bob', 'Williams', '456-789-0123', 'bob.williams@example.com', 4, 5.0, 'ML Innovations', 4, 'Chicago'),
    ('Carol', 'Davis', '567-890-1234', 'carol.davis@example.com', 5, 4.5, 'JS Designs', 5, 'Seattle'),
    ('David', 'Wilson', '678-901-2345', 'david.wilson@example.com', 6, 6.0, 'UX Experts', 6, 'Austin'),
    ('Eve', 'Martinez', '789-012-3456', 'eve.martinez@example.com', 7, 2.0, 'MarketMasters', 7, 'Miami'),
    ('Frank', 'Anderson', '890-123-4567', 'frank.anderson@example.com', 8, 3.5, 'SecureNet', 8, 'Denver'),
    ('Grace', 'Thomas', '901-234-5678', 'grace.thomas@example.com', 9, 7.0, 'CloudTech', 9, 'Boston'),
    ('Hannah', 'Jackson', '012-345-6789', 'hannah.jackson@example.com', 10, 1.5, 'StackBuild', 10, 'Philadelphia'),
    ('Isaac', 'White', '123-456-7891', 'isaac.white@example.com', 1, 0.5, 'DevLabs', 1, 'New York'),
    ('Judy', 'Harris', '234-567-8902', 'judy.harris@example.com', 2, 2.0, 'TechTree', 2, 'San Francisco'),
    ('Karl', 'Lewis', '345-678-9013', 'karl.lewis@example.com', 3, 3.5, 'CodeWorks', 3, 'Los Angeles'),
    ('Laura', 'Clark', '456-789-0124', 'laura.clark@example.com', 4, 4.0, 'DataDrive', 4, 'Chicago'),
    ('Mike', 'Roberts', '567-890-1235', 'mike.roberts@example.com', 5, 5.5, 'WebWizards', 5, 'Seattle'),
    ('Nina', 'Miller', '678-901-2346', 'nina.miller@example.com', 6, 6.5, 'DesignLab', 6, 'Austin'),
    ('Oscar', 'Garcia', '789-012-3457', 'oscar.garcia@example.com', 7, 2.5, 'PromoWorks', 7, 'Miami'),
    ('Paula', 'Rodriguez', '890-123-4568', 'paula.rodriguez@example.com', 8, 3.0, 'SecuNet', 8, 'Denver'),
    ('Quincy', 'Lewis', '901-234-5679', 'quincy.lewis@example.com', 9, 7.5, 'CloudWorld', 9, 'Boston'),
    ('Rachel', 'Walker', '012-345-6790', 'rachel.walker@example.com', 10, 1.0, 'BuildIt', 10, 'Philadelphia'),
    ('Steve', 'Hall', '123-456-7892', 'steve.hall@example.com', 1, 4.5, 'InnovateTech', 1, 'New York'),
    ('Tina', 'Allen', '234-567-8903', 'tina.allen@example.com', 2, 2.5, 'CodeLeap', 2, 'San Francisco'),
    ('Ursula', 'Young', '345-678-9014', 'ursula.young@example.com', 3, 5.0, 'ML Insights', 3, 'Los Angeles'),
    ('Victor', 'Scott', '456-789-0125', 'victor.scott@example.com', 4, 3.5, 'TechNova', 4, 'Chicago');

-- queries --

-- 1. Give me the records of employee getting highest salary
select * from employees order by salary desc limit 1;

-- 2. give me the record of the employee getting highest salary and age is > 25
select * from employees where age > 25 order by salary desc limit 1;

-- 2. give me the record of the 2nd employee getting highest salary and age is > 25
select * from employees where age > 25 order by salary desc limit 1 offset 1;

-- 3. display number of students who enrolled the courses
select count(*) as total_enrollments from students;

-- 4. display the number of enrollments for the course "Data Science Bootcamp"
select count(*) as dataScience_enrollments from students where course=2;

-- 5. count number of enrollments in the current month
select count(*) as august_enrolls from students where date(enroll_date) between '2024-01-01' AND '2024-12-31';

-- 6. count the number of companies user belongs to
select count(distinct company) from students;

-- 7. count the number of students who joined the course via source
select source_of_join, count(*) as enrolled_students from students group by source_of_join;

-- 8. corresponding to the source of joining give me the max years of experience any person hold
select source_of_join, max(experience) as experience from students group by source_of_join;

-- 9. display the courses which doesn't include word "Fundamentals"
select * from courses where name not like "Fundamentals";

-- 10. display the records of those student who have less than 4 years of experience and source of joining is WhatsApp
select * from students where experience < 4 and source_of_join=6;

-- 11. display the records of those who have experiences between 1 and 3 years
select * from students where experience between 1 and 3;

-- 12. for each address, what is the count of each employee and avg salary of the employee in those location.
select location, count(*) as total, avg(salary) as avg_salary
from employees
group by location;

-- 13. for each address, what is the count of each employee and avg salary of the employee in those address, but also display firstName and lastName corresponding to each record
select first_name, last_name, employees.location, total, avg_salary
from employees
join (
    select location, count(*) as total, avg(salary) as avg_salary
    from employees
    group by location
) as temp
on employees.location = temp.location;
-- optimized version
select first_name, last_name, location, 
    count(location) over (partition by location) as total, 
    avg(salary) over (partition by location) as avg_salary 
from employees;

-- 14. which course has the highest enrollments
select course, count(id) as enrollment_counts
from students
group by course
order by enrollment_counts desc
limit 1;

-- case statements in SQL
	-- case
		-- when condition then text
		-- else text
	-- end as alias name

-- create a new column name "fee_status" based on
	-- fee > 3999 => Expensive
	-- fee > 1499 => Moderate
	-- else > Cheap
select id, name, fees,
    case
        when fees > 499 then "Expensive"
        when fees > 399 then "Moderate"
        else "Cheap"
    end as fee_status
from courses;

-- case expressions in SQL
-- type: premium, plus, regular
select id, name, fees,
    case
        when 499 then "Premium"
        when 399 then "Plus"
        else "Regular"
    end as course_type
from courses;

-- common table expressions
-- useful for when dealing with complex queries

-- payment status table
create table payment_status (
    id int auto_increment primary key,
    title varchar(50) not null
);

insert into payment_status(title) values
    ("Completed"),
    ("Pending"),
    ("Canceled");

-- orders table
create table orders (
    id int auto_increment primary key,
    payment_date date not null default(current_date),
    student int not null,
    status int not null,

    foreign key(student) references students(id),
    foreign key(status) references payment_status(id)
);

insert into orders (payment_date, student, status)  values 
    ('2024-02-01', 1, 1),
	('2024-01-15', 2, 3),
	('2024-01-10', 3, 2),
	('2024-02-02', 4, 1),
	('2024-02-05', 5, 1),
	(current_date, 6, 3);

-- total orders per student
select student, count(id) as total_orders 
from orders
group by student;

-- total orders per student whose status is completed
select student, count(id) as total_orders 
from orders
where status=1
group by student;

-- total orders per student along with their name
select student, first_name, last_name, count(orders.id) as total_orders
from orders 
join students on orders.id=students.id 
group by student, first_name, last_name;

-- optimized
select student, temporary.first_name, temporary.last_name, count(orders.id) as total_orders 
from orders 
join (
    select id, first_name, last_name from students
) as temporary on orders.id=temporary.id 
group by student, temporary.first_name, temporary.last_name;

-- total orders per student along with their name & status
select student, first_name, last_name, title, count(orders.id) as total_orders 
from orders 
join students on orders.id=students.id 
join payment_status on orders.id=payment_status.id 
group by student, first_name, last_name, title;
-- or
select student, first_name, last_name, count(orders.id) as total_orders, title 
from orders 
join students on orders.id=students.id 
join payment_status on orders.id=payment_status.id 
group by student, first_name, last_name, title;

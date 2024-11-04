---1---
create database lab6;

---2---
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);


insert into locations (street_address, postal_code, city, state_province)
values
('14 Willow Lane', '56789', 'Phoenix', 'AZ'),
('890 Cedar Blvd', '12312', 'Dallas', 'TX'),
('55 Elm St', '45678', 'San Diego', 'CA'),
('333 Birch Ave', '78901', 'San Francisco', 'CA'),
('222 Aspen Rd', '10203', 'Miami', 'FL'),
('10 Magnolia Dr', '55555', 'Boston', 'MA'),
('123 Redwood Way', '34567', 'Seattle', 'WA'),
('777 Spruce Rd', '67676', 'Portland', 'OR'),
('67 Palm St', '88888', 'Las Vegas', 'NV'),
('459 Maple Ave', '99999', 'Denver', 'CO');


insert into departments (department_name, budget, location_id)
values
('Product', 600000, 5),
('Operations', 450000, 6),
('Customer Service', 250000, 7),
('IT', 700000, 8),
('Finance', 550000, 9),
('Legal', 300000, 10),
('R&D', 900000, 1),
('Logistics', 350000, 2),
('Public Relations', 320000, 3),
('Compliance', 275000, 4);


insert into employees (first_name, last_name, email, phone_number, salary, department_id)
values
('Sophia', 'Taylor', 'sophiataylor@example.com', '567-890-1234', 85000, 5),
('James', 'Anderson', 'jamesanderson@example.com', '678-901-2345', 95000, 6),
('Olivia', 'Martinez', 'oliviamartinez@example.com', '789-012-3456', 87000, 7),
('William', 'Garcia', 'williamgarcia@example.com', '890-123-4567', 92000, 8),
('Ava', 'Lee', 'avale@example.com', '901-234-5678', 88000, 9),
('Liam', 'Wilson', 'liamwilson@example.com', '012-345-6789', 78000, 10),
('Isabella', 'Clark', 'isabellaclark@example.com', '234-567-8901', 82000, 1),
('Mason', 'Lewis', 'masonlewis@example.com', '345-678-9012', 97000, 2),
('Mia', 'Hall', 'miahall@example.com', '456-789-0123', 89000, 3),
('Elijah', 'Allen', 'elijahallen@example.com', '567-890-1234', 85000, 4);



---3---
select e.first_name, e.last_name, d.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id;


---4---
select e.first_name, e.last_name, d.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where d.department_id = 40 or d.department_id = 80;

---5---
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id;


---6---
select d.department_id, d.department_name, e.first_name, e.last_name
from departments d
left join employees e on d.department_id = e.department_id;

---7---
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
left join departments d on e.department_id = d.department_id;
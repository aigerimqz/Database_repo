create database lab7;

create table countries (
    country_id serial primary key,
    name varchar(100),
    code varchar(3) unique
);


create table departments (
    department_id serial primary key,
    name varchar(100),
    budget integer
);


create table employees (
    employee_id serial primary key,
    name varchar(50),
    surname varchar(50),
    country_id int references countries(country_id),
    department_id int references departments(department_id),
    salary integer
);


insert into countries (name, code)
values
    ('Kazakhstan', 'KZ'),
    ('United States', 'US'),
    ('Canada', 'CA'),
    ('China', 'CN'),
    ('Germany', 'DE'),
    ('Japan', 'JP');


insert into departments (name, budget)
values
    ('Engineering', 500000),
    ('Marketing', 300000),
    ('Human Resources', 150000),
    ('Finance', 250000),
    ('Research', 400000);


insert into employees (name, surname, country_id, department_id, salary)
values
    ('Aiman', 'Zhakslyk', 1, 1, 70000),
    ('John', 'Doe', 2, 2, 80000),
    ('Jane', 'Smith', 3, 3, 90000),
    ('Li', 'Wei', 4, 4, 85000),
    ('Hiro', 'Tanaka', 6, 5, 95000),
    ('Sara', 'Müller', 5, 1, 78000),
    ('Mike', 'Johnson', 2, 3, 88000),
    ('Aibol', 'Tilek', 1, 4, 92000),
    ('Chen', 'Wang', 4, 5, 91000),
    ('Emma', 'Brown', 3, 2, 87000),
    ('Janette', 'Jackson', 2, 4, 92000);



--- 1 ---
create index countries_name_index
on countries (name);

explain analyse select * from countries where name = 'Germany';
-- without index - 0.025 ms
-- with index - 0.023 ms

--- 2 ---
create index employees_name_surname_index
on employees(name, surname);

explain analyse select * from employees where name = 'Emma' and surname = 'Brown';
-- without - 0.197 ms
-- with - 0.023 ms

--- 3 ---
create index employees_salary_index
on employees(salary);


explain analyse select * from employees where salary < 80000 and salary > 50000;
-- without - 0.042 ms
-- with - 0.023 ms

--- 4 ---
create index employees_name_substring_index
on employees(substring(name from 1 for 4));

explain analyse select * from employees where substring(name from 1 for 4) = 'Jane';
-- without - 0.024 ms
-- with - 0.023 ms

--- 5 ---

create index employees_departments_salary_budget
on employees(salary);

create index departments_budget
on departments(budget);



explain analyse select * from employees e
join departments d
on d.department_id = e.department_id
where d.budget > 400000 and e.salary < 80000;

-- without 0.048 ms
-- with 0.045 ms

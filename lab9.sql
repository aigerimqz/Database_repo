create database lab9;



create table employees
(
    emp_id       serial primary key,
    emp_name     varchar(100) not null,
    emp_position varchar(50),
    emp_salary   integer
);

insert into employees (emp_name, emp_position, emp_salary)
values ('Alice Johnson', 'Manager', 80000),
       ('Bob Smith', 'Engineer', 60000),
       ('Charlie Lee', 'Technician', 40000),
       ('Dana White', 'Analyst', 55000);

create table products
(
    p_id       serial primary key,
    p_name     varchar(100) not null,
    p_price    real         not null,
    p_category varchar(50)  not null
);

insert into products (p_name, p_price, p_category)
values ('Laptop', 1200.50, 'Electronics'),
       ('Smartphone', 800.99, 'Electronics'),
       ('Desk chair', 150.00, 'Furniture'),
       ('Bookshelf', 300.00, 'Furniture'),
       ('Coffee maker', 99.99, 'Appliances');



--- 1 ---
create or replace function increase_value(value int)
    returns int as
$$
begin
    return value + 10;
end;
$$
    language plpgsql;


select increase_value(100);

--- 2 ---
create or replace function compare_numbers(num1 int, num2 int, out result varchar)
    returns varchar as
$$
begin
    if num1 > num2 then
        result := 'Greater';
    elsif num1 = num2 then
        result := 'Equal';
    else
        result := 'Lesser';
    end if;
end;
$$
    language plpgsql;


select compare_numbers(1, 2);

--- 3 ---
create or replace function number_series(n int)
    returns table
            (
                series int
            )
as
$$
declare
    i int := 1;
begin
    while i <= n
        loop
            series := i;
            return next;
            i := i + 1;
        end loop;
    return;
end;
$$
    language plpgsql;

select number_series(10);
--- 4 ---
create or replace function find_employee(emp_param varchar)
    returns table
            (
                id     int,
                name   varchar,
                pos    varchar,
                salary int
            )
as
$$
begin
    return query select emp_id, emp_name, emp_position, emp_salary
                 from employees
                 where emp_name = emp_param;
end;
$$
    language plpgsql;


select find_employee('Dana White');


--- 5 ---
create or replace function list_products(category varchar)
    returns table
            (
                id           int,
                product_name varchar,
                product_cost real,
                categ        varchar
            )
as
$$
begin
    return query select p_id, p_name, p_price, p_category
                 from products
                 where p_category = category;
end;
$$
    language plpgsql;

drop function list_products(category varchar);

select list_products('Electronics');

--- 6 ---
create or replace function calculate_bonus(id int, percentage real, out bonus real)
    returns real as
$$
declare
    salary int;
begin
    select emp_salary into salary from employees where emp_id = id;

    bonus := salary * (percentage / 100);
end;
$$
    language plpgsql;

select calculate_bonus(1, 50);

create or replace function update_salary(id int, bonus real)
    returns void as
$$
begin
    perform calculate_bonus(id, bonus);

    update employees
    set emp_salary = emp_salary + bonus
    where emp_id = id;
end;
$$
    language plpgsql;

select update_salary(1, calculate_bonus(1, 50));
drop function update_salary(id int);


select *
from employees;


--- 7 ---

create or replace function complex_calculation(san int, soz varchar, out result varchar)
    returns varchar as
$$
declare
    numeric_result int;
    text_result    varchar;
begin
    <<main_block>>
    begin
        <<numeric_block>>
        begin
            numeric_result := san * 2;
        end numeric_block;


        <<text_block>>
        begin
            text_result := soz || reverse(soz);

        end text_block;

        result := 'Numeric Result: ' || numeric_result || ', Text Result: ' || text_result;
    end main_block;
end;
$$
    language plpgsql;


select complex_calculation(5, 'Hello');


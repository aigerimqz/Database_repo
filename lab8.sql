--- 1 ---
create database lab8;

--- 2 ---
create table salesman(
    salesman_id serial primary key,
    name varchar(255),
    city varchar(255),
    commission real
);

create table customers(
    customer_id serial primary key,
    cust_name varchar(255),
    city varchar(255),
    grade integer,
    salesman_id integer references salesman(salesman_id)
);

create table orders(
    ord_no serial primary key,
    purch_amt real,
    ord_date date,
    customer_id integer references customers(customer_id),
    salesman_id integer references salesman(salesman_id)
);


insert into salesman
values (5001, 'James Hoog', 'New York', 0.15),
       (5002, 'Nail Knite', 'Paris', 0.13),
       (5005, 'Pit Alex', 'London', 0.11),
       (5006, 'Mc Lyon', 'Paris', 0.14),
       (5003, 'Lauson Hen', null, 0.12),
       (5007, 'Paul Adam', 'Rome', 0.13);

insert into customers
values (3002, 'Nick Rimando', 'New York', 100, 5001),
       (3005, 'Graham Zusi', 'California', 200, 5002),
       (3001, 'Brad Guzan', 'London', null, 5005),
       (3004, 'Fabian Johns', 'Paris', 300, 5006),
       (3007, 'Brad Davis', 'New York', 200, 5001),
       (3009, 'Geoff Camero', 'Berlin', 100, 5003),
       (3008, 'Julian Green', 'London', 300, 5002);

insert into orders
values (70001, 150.5, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3001, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.5, '2012-08-17', 3009, 5003),
       (70007, 948.5, '2012-09-10', 3005, 5002),
       (70005, 2400.6, '2012-07-27', 3007, 5001),
       (70008, 5760, '2012-09-10', 3002, 5001);



--- 3 ---
create role junior_dev login;

--- 4 ---
create view belong_to_NewYork
    as select * from salesman
                where city = 'New York';

select * from belong_to_NewYork;


--- 5 ---
create view view_name as
    select s.name, c.cust_name
        from salesman s
            join customers c on s.salesman_id = c.salesman_id;



grant all privileges on viewbyname to junior_dev;


--- 6 ---
create view high_grade as
    select * from customers
             where grade = (select max(grade) from customers);
grant select on high_grade to junior_dev;


--- 7 ---
create view show_num as
    select city, count(*) from salesman
                          group by city;

select * from show_num;


--- 8 ---
create view morethanone as
    select s.name, count(c.salesman_id) from salesman s
        join customers c on s.salesman_id = c.salesman_id
            group by s.salesman_id, s.name
                having count(c.customer_id) > 1;


--- 9 ---
create role intern;
grant junior_dev to intern;



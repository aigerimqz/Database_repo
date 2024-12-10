create database lab10;

create table books
(
    book_id serial primary key,
    title varchar,
    author varchar,
    price decimal,
    quantity integer
);

create table orders
(
    order_id serial primary key,
    book_id integer references books(book_id),
    customer_id integer,
    order_date date,
    quantity integer

);

create table customers
(
    customer_id serial primary key,
    name varchar,
    email varchar
);

insert into books (title, author, price, quantity)
values ('Database 101', 'A.Smith', 40.00, 10),
        ('Learn SQL', 'B.Johnson', 35.00, 15),
        ('Advanced DB', 'C.Lee', 50.00, 5);

insert into customers (customer_id, name, email)
values (101,'John Doe', 'johndoe@example.com'),
        (102, 'Jane Doe', 'janedoe@example.com');

--- Tasks ---
--- 1 ---
begin;
insert into orders (customer_id, order_date, quantity, book_id)
values (101, '2024-12-01', 2, 1);

update books
set quantity = quantity - 2
where book_id = 1;

commit;

select * from orders;
select * from books;

--- 2 ---
begin;

do $$
begin
    if(select quantity from books where book_id = 3) < 10 then
        raise exception 'There is not enough stock for book #3';
    else
        insert into orders (book_id, customer_id, order_date, quantity)
        values (3, 102, '2024-12-02', 10);

        update books
        set quantity = quantity - 10
        where book_id = 3;
    end if;
end $$;

rollback;

--- 3 ---
--- First session
set transaction isolation level read committed;
begin;

update books
set price = 60.00
where book_id = 3;

commit;


--- Second session
set transaction isolation level read committed;

begin;
select price from books where book_id = 3;

commit;



--- 4 ---
begin;

update customers
set email = 'johndoe111@example.com'
where customer_id = 101;

commit;


select * from customers;
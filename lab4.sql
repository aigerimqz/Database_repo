--- 1 ---
create database lab4;

--- 2 ---
create table Warehouses(
    code serial primary key,
    location varchar(255),
    capacity integer
);

create table Boxes(
    code char(4),
    contents varchar(255),
    value real,
    warehouse integer
);


--- 3 ---
insert into Warehouses(location, capacity)
values
    ('Chicago', 3),
    ('Chicago', 4),
    ('New York', 7),
    ('Los Angeles', 2),
    ('San Francisco', 8);

insert into Boxes(code, contents, value, warehouse)
values
    ('0MN7', 'Rocks', 180, 3),
    ('4H8P', 'Rocks', 250, 1),
    ('4RT3', 'Scissors', 190, 4),
    ('7G3H', 'Rocks', 200, 1),
    ('8JN6', 'Papers', 75, 1),
    ('8Y6U', 'Papers', 50, 3),
    ('9J6F', 'Papers', 175, 2),
    ('LL08', 'Rocks', 140, 4),
    ('P0H6', 'Scissors', 125, 1),
    ('P2T6', 'Scissors', 150, 2),
    ('TU55', 'Papers', 90, 5);


--- 4 ---
select * from Warehouses;

--- 5 ---
select * from Boxes
    where value > 150;

--- 6 ---
select distinct contents from Boxes;

--- 7 ---
select code as warehouse_code,
    (select count(*)
        from Boxes
            where warehouse = Warehouses.code) as number_of_boxes
from Warehouses;

--- 8 ---
select code as warehouse_code,
    (select count(*)
        from Boxes
            where warehouse = Warehouses.code) as number_of_boxes
from Warehouses
where (select count(*)
        from Boxes
            where warehouse = Warehouses.code) > 2;


--- 9 ---
insert into Warehouses(location, capacity)
values
    ('New York', 3);

--- 10 ---
insert into Boxes(code, contents, value, warehouse)
values
    ('H5RT', 'Papers', 200, 2);

--- 11 ---
update Boxes set value = value * 0.85
    where value =
          (select value from Boxes order by value desc limit 1 offset 2);

select * from Boxes;


--- 12 ---
delete from Boxes where value < 150;

--- 13 ---
delete from Warehouses
    where location = 'New York'
    returning *;

--- 1 ---
create database lab2;

--- 2 ---
create table countries(
    country_id serial primary key,
    country_name text,
    region_id integer,
    population integer
);
--- 3 ---
insert into countries(country_name, region_id, population) values('Turkey', 792, 84980000);


--- 4 ---
insert into countries(country_id, country_name) values(2, 'Switzerland');


--- 5 ---
insert into countries(region_id) values(NULL);

--- 6 ---
insert into countries(country_name, region_id, population)
values
    ('Japan', 392, 123000000),
    ('Germany', 276, 84000000),
    ('Liechtenstein', 423, 38380);



--- 7 ---
alter table countries alter column country_name set default 'Kazakhstan';

--- 8 ---
insert into countries(country_name) values(default);

--- 9 ---
insert into countries default values;

--- 10 ---
create table countries_new (like countries);

--- 11 ---
insert into countries_new select * from countries;

--- 12 ---
update countries set region_id = 1 where region_id is NULL;

--- 13 ---
update countries set population = population * 1.1 returning country_name, population as New_Population;

--- 14 ---

delete from countries where (population < 100000);

--- 15 ---
delete from countries_new where country_id in (select country_id from countries) returning *;

--- 16 ---
delete from countries returning *;
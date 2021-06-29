-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

drop database if exists shop;
create database shop;
use shop;

drop table if exists users;
create table users(
	id serial primary key,
 	name varchar(255)
);

drop database if exists sample;
create database sample;
use sample;

drop table if exists users;
create table users(
	id serial primary key,
 	name varchar(255)
);

use shop;

insert into users values
	('1', 'Nick'),
	('2', 'Yara'),
	('3', 'Anna'),
	('4', 'Mark'),
	('5', 'Lada'),
	('6', 'Valera');
	
start transaction;
insert into sample.users select * from shop.users users where id = 1;
commit;
select * from sample.users;

-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

use shop;

drop table if exists catalogs;
create table catalogs(
	id serial primary key,
	name varchar(255)
);
drop table if exists products;
create table products(
	id serial primary key,
	name varchar(255),
	catalog_id int unsigned
);

insert into catalogs
	(id, name)
values
	('1', 'video card'),
	('2', 'processors'),
	('3', 'motherboard');
	
insert into products
	(id, name, catalog_id)
values
	('1', 'Intel Core i3-8100', 1),
	('2', 'AMD FX-8320E', 2),
	('3', 'MSI B250M GAMING PRO', 3);
	
select p.id as id, p.name, cat.name
from products as p
left join catalogs as cat 
on p.catalog_id = cat.id;
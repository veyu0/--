drop database if exists shop;
create database shop;
use shop;

-- —оздайте таблицу logs типа Archive. 
-- ѕусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещаетс€ врем€ и дата создани€ записи, 
-- название таблицы, идентификатор первичного ключа и содержимое пол€ name.


drop table if exists logs;
create table logs(
	created_at datetime not null,
	table_name varchar(45) not null,
	str_id bigint(20) not null,
	name_value varchar(45) not null
) ENGINE = ARCHIVE;



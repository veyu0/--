-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
drop database if exists homework;
create database homework;
use homework;

drop table if exists users;
create table users(
	id serial,
	name varchar(255),
	order_value bigint
);

insert into users values
	(1, 'Valentin', 1),
	(2, 'Yuri', 5),
	(3, 'Vera', 4);

select 
	name 
from 
	users
where
	order_value > 0;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

drop table if exists catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

 DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 7890.00, 1),
  ('Intel Core i5-7400', 12700.00, 1),
  ('AMD FX-8320E', 4780.00, 1),
  ('AMD FX-8320', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 19310.00, 2),
  ('Gigabyte H310M S2H', 4790.00, 2),
  ('MSI B250M GAMING PRO', 5060.00, 2);

 select
	products.name as product_name,
	catalogs.name as catalog_name
from
	products
inner join catalogs on catalogs.id = products.catalog_id;
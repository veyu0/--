drop database if exists geekbrains;
create database geekbrains;
use geekbrains;
-- ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
-- ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������

drop table if exists users;
create table users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

drop table if exists storehouses_products;
create table storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� �������.

insert into storehouses_products
  (value)
values
	('0'),
	('2500'),
	('0'),
	('30'),
	('500'),
	('1');
	
select * from storehouses_products
  order by case when value = 0 then 2147483647 else value end;
  
 
-- ����������� ������� ������� ������������� � ������� users
 
 insert into users (birthday_at) values
  ('1990-10-05'),
  ('1984-11-12'),
  ('1985-05-20'),
  ('1988-02-14'),
  ('1998-01-12'),
  ('1992-08-29');
  
 select round(avg(t(year, birthday_at, now())), 0) as AVG_Age from users;
 
-- ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.

select
    dayname(concat(year(now()), '-', substring(birthday_at, 6, 10))) as week_day_of_birthday_in_this_Year,
    count(*) as amount_of_birthday
from 
    users
group by 
    week_day_of_birthday_in_this_Year
order by
	amount_of_birthday desc;
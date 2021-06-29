drop database if exists shop;
create database shop;
use shop;

-- �������� ������� logs ���� Archive. 
-- ����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� ����� � ���� �������� ������, 
-- �������� �������, ������������� ���������� ����� � ���������� ���� name.


drop table if exists logs;
create table logs(
	created_at datetime not null,
	table_name varchar(45) not null,
	str_id bigint(20) not null,
	name_value varchar(45) not null
) ENGINE = ARCHIVE;



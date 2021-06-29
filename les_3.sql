drop database if exists vk;
create database vk;
use vk;

drop table if exists playlist;
create table playlist(
	id serial,
	playlist_name varchar(255),
	song_name varchar(255),
	
	index playlist_name_idx(playlist_name)
);

drop table if exists my_music;
create table my_music(
	id serial,
	playlist_id varchar(255),
	song_name varchar(255),
	
	foreign key (playlist_id) references playlist(id)
);

drop table if exists for_you;
create table for_you(
	id serial,
	Musicians_for_You varchar(255),
	According_To_your_preferences varchar(255),
	Recently_listened_to varchar(255)
);

drop table if exists review;
create table review(
	id serial,
	novelties varchar(255),
	new_album varchar(255),
	Vkontakte_Chart varchar(255)
);

drop table if exists friends_music;
create table friends_music(
	id serial,
	user_id varchar(255),
	songs varchar(255),
	created_at datetime default now()
);

drop table if exists music;
create table music(
	my_music varchar(255),
	for_you varchar(255),
	review varchar(255),
	friends_music varchar(255),
	
	index searching_idx(my_music, for_you, review, friends_music),
	
	foreign key (my_music) references my_music(id),
	foreign key (for_you) references for_you(id),
	foreign key (review) references review(id),
	foreign key (friends_music) references friends_music(id)
);
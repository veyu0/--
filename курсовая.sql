/*
База данных Apple Music. Она хранит данные о всей музыке, когла либо загружаемую на эту площадку. 
Также собирает данные о ваших прослушиваниях, их частоте и количестве часов.
*/

drop database if exists apple_music;
create database apple_music;
use apple_music;

drop table if exists artists;
create table artists(
	artist_name varchar(50),
	
	index artist_idx(artist_name)
);

	insert into artists
	values
		('ABRA'),
		('Afterparty'),
		('Ariana Grande'),
		('Avega'),
		('Beyonce'),
		('Big Baby Tape'),
		('The Neighbourhood'),
		('Элджей'),
		('twenty one pilots'),
		('Travis Scott'),
		('Jesse'),
		('Rihanna'),
		('Gorillaz'),
		('Labrinth'),
		('blackbear'),
		('Lil Peep'),
		('100 gecs');

drop table if exists songs;
create table songs(
	song_name varchar(50),
	duration int,
	artist varchar(50),
	album_name varchar(50),
	genre varchar(50),
	auditioned bigint,
	
	index song_idx(song_name),
	foreign key (artist) references artists(artist_name)
);

insert into songs
values
	('Roses', 3, 'ABRA', 'Rose', 'Соул', 79),
	('7 rings', 4, 'Ariana Grande', 'thank u,', 'Поп', 16),
	('Передай', 2.5, 'Avega', 'Барни Гамбл рэп', 'Хип-хоп', 13),
	('7\11', 5, 'Beyonce', 'BEYONCE', 'Поп', 33),
	('Flawless', 2.6,  'Beyonce', 'BEYONCE', 'Поп', 3),
	('Surname', 3, 'Big Baby Tape', 'Arguments & facts', 'Хип-хоп', 30),
	('Brigada', 2.7, 'Big Baby Tape', 'Arguments & facts', 'Хип-хоп', 94),
	('ACAB', 3, 'Big Baby Tape', 'Dragonborn', 'Хип-хоп', 17),
	('Sayonara детка', 3, 'Элджей', 'Single', 'Хип-хоп', 170),
	('Дисконект', 2.3, 'Элджей', 'Single', 'Хип-хоп', 61),
	('R.I.P to my youth', 3.1, 'The Neighbourhood', 'Wiped out!', 'Альтернатива', 26),
	('Wake up', 3.4, 'Travis Scott', 'ASTROWORLD', 'Хип-хоп', 50),
	('Stressed out', 3.2, 'twenty one pilots', 'Blurryface', 'Поп' , 2),
	('Bff', 3, 'Jesse', '&', 'Поп', 9),
	('Formula', 1.5, 'Labrinth', 'Euphoria', 'Саундреки', 97),
	('Forever', 1.5, 'Labrinth', 'Euphoria', 'Саундреки', 23),
	('when i r.i.p', 1.5, 'Labrinth', 'Euphoria', 'Саундреки', 86),
	('hot girl bummer', 3, 'blackbear', 'Single', 'Хип-хоп', 34),
	('Sex with my ex', 2.6, 'Lil Peep', 'Come Over When Youre Sober, Pt. 2 (Bonus)', 'Хип-хоп', 60),
	('money machine', 1.5, '100 gecs', '1000 gecs', 'Альтернатива', 13),
	('hand crushed by a mallet', 2, '100 gecs', '1000 gecs', 'Альтернатива', 333);

select artist
from songs
union
select artist_name
from artists;

drop table if exists last_added;
create table last_added(
	added text,
	artist varchar(50),
	album_name varchar(50),
	
	index song_idx(album_name),
	foreign key (artist) references artists(artist_name)
);

insert into last_added values
	('сегодня','Travis Scott', 'ASTROWORLD'),
	('сегодня','Labrinth', 'Euphoria'),
	('сегодня','Big Baby Tape', "Dragonborn"),
	('вчера','blackbear', 'hot girl bummer - Single'),
	('в этом месяце','Lil Peep', 'Come Over When Youre Sober, Pt. 2 (Bonus)'),
	('сегодня', 'Lil Peep', 'HELLBOY'),
	('в этом месяце', '100 gecs', '1000 gecs');

select 
	added, artist, album_name
from last_added
where artist = (select artist from songs where artist = 'Lil Peep');

drop table if exists albums;
create table albums(
	artist varchar(50),
	album_name varchar(50),
	songs bigint,
	
	index album_idx(album_name)
);

insert into albums values
	('Lil Peep', 'Come Over When Youre Sober, Pt. 2 (Bonus)', 7),
	('Labrinth', 'Euphoria', 20),
	('Big Baby Tape', 'Dragonborn', 23),
	('ABRA', 'Rose', 10),
	('Ariana Grande', 'thank u,', 12),
	('Beyonce', 'BEYONCE', 7),
	('Big Baby Tape', 'Arguments & facts', 5),
	('The Neighbourhood', 'Wiped Out!', 11),
	('twenty one pilots', 'Blurry face', 14),
	('Travis Scott', 'ASTROWORLD', 2),
	('Jesse', '&', 11),
	('100 gecs', '1000 gecs', 4)
	;

select
	a.artist, a.album_name, s.album_name
from
	albums as a join songs as s
on
	a.artist = s.artist;

drop table if exists genres;
create table genres(
	genre_name varchar(50),
	album varchar(50),
	song varchar(50),
	
	index genre_idx(genre_name),
	-- foreign key (album) references albums(album_name),
	foreign key (song) references songs(song_name)
);

insert into genres values
	('Соул', 'Rose', 'Roses'),
	('Поп', 'thank u,', '7 rings'),
	('Поп', 'BEYONCE', '7\11'),
	('Поп', 'BEYONCE', 'Flawless'),
	('Поп', 'Blurryface', 'Stressed out'),
	('Поп', '&', 'Bff'),
	('Хип-хоп', 'Барни Гамбл рэп', 'Передай'),
	('Хип-хоп', 'Arguments & facts', 'Surname'),
	('Хип-хоп', 'Arguments & facts', 'Brigada'),
	('Хип-хоп', 'Dragonborn', 'ACAB'),
	('Хип-хоп', 'ASTROWORLD', 'Wake up'),
	('Хип-хоп', 'Come Over When Youre Sober, Pt. 2 (Bonus)', 'Sex with my ex'),
	('Альтернатива', 'Wiped out!', 'R.I.P to my youth'),
	('Альтернатива', '1000 gecs', 'money machine'),
	('Альтернатива', '1000 gecs', 'hand crushed by a mallet'),
	('Саундтреки', 'Euphoria', 'Formula'),
	('Саундтреки', 'Euphoria', 'Forever'),
	('Саундтреки', 'Euphoria', 'when i r.i.p')
	;

drop table if exists video_clips;
create table video_clips(
	artist_name varchar(50),
	song_name varchar(50),
	
	foreign key (song_name) references songs(song_name),
	foreign key (artist_name) references artists(artist_name)
);

insert into video_clips values
	('Элджей', 'Sayonara детка'),
	('Beyonce', '7\11')
	;

drop table if exists downloaded;
create table downloaded(
	artist varchar(50),
	album_name varchar(50)
	
	-- foreign key (album_name) references albums(album_name)
);

insert into downloaded values
	('ABRA', 'Rose'),
	('Ariana Grande', 'thank u,'),
	('Beyonce', 'BEYONCE'),
	('twenty one pilots', 'Blurryface'),
	('Jesse', '&'),
	('Avega', 'Барни Гамбл рэп'),
	('Big Baby Tape', 'Arguments & facts'),
	('Big Baby Tape', 'Dragonborn'),
	('Travis Scott', 'ASTROWORLD'),
	('Lil Peep', 'Come Over When Youre Sober, Pt. 2 (Bonus)'),
	('he Neighbourhood', 'Wiped out!'),
	('100 gecs', '1000 gecs'),
	('Labrith', 'Euphoria')
	;

drop table if exists playlists;
create table playlists(
	name varchar(50),
	artist_name varchar(50),
	song_name varchar(50),
	year_release bigint,
	genre varchar(50),
	duration bigint,
	
	index playlist_idx(name),
	foreign key (song_name) references songs(song_name)
);

insert into playlists values
	('confident', 'Big Baby Tape', 'Surname', 2018, 'Хип-хоп', 3),
	('confident', 'Big Baby Tape', 'Brigada', 2018, 'Хип-хоп', 2.7),
	('confident', 'Элджей', 'Sayonara детка', 2019, 'Хип-хоп', 3),
	('confident', 'Элджей', 'Дисконект', 2016, 'Хип-хоп', 2.3),
	('confident', '100 gecs', 'money machine', 2015, 'Альтернатива', 1.5),
	('confident', '100 gecs', 'hand crushed by a mallet', 2015, 'Альтернатива', 2),
	('fav', 'The Neighbourhood', 'R.I.P to my youth', 2013, 'Альтернатива', 3.1),
	('fav', 'twenty one pilots', 'Stressed out', 2014, 'Поп', 3.2),
	('fav', 'Labrinth', 'Formula', 2019, 'Саундтреки', 1.5),
	('fav', 'Labrinth', 'Forever', 2019, 'Саундреки', 1.5),
	('fav', 'Labrinth', 'when i r.i.p', 2019, 'Саундреки', 1.5)
	;

create or replace view pl as
select count(name) as name, artist_name, song_name
from playlists
group by name;

select * from pl;

drop table if exists favorite_songs;
create table favorite_songs(
	song_name varchar(50),
	artist varchar(50),
	album_name varchar(50),
	duration bigint,
	updated datetime on update current_timestamp,
	
	foreign key (song_name) references songs(song_name),
	foreign key (artist) references artists(artist_name)
);

insert into favorite_songs(song_name, artist, album_name, duration) values
	('7\11', 'Beyonce', 'BEYONCE', 5),
	('R.I.P to my youth', 'The Neighbourhood', 'Wiped out!', 3.1),
	('Stressed out', 'twenty one pilots', 'Blurryface', 3.2),
	('Formula', 'Labrinth', 'Euphoria', 1.5),
	('Forever', 'Labrinth', 'Euphoria', 1.5),
	('when i r.i.p', 'Labrinth', 'Euphoria', 1.5)
	;

create or replace view fs as
select song_name, artist
from favorite_songs
order by song_name;

select * from fs;

drop table if exists mix;
create table mix(
	song_name varchar(50),
	artist varchar(50),
	album_name varchar(50),
	duration bigint,
	updated datetime on update current_timestamp
);

insert into mix(song_name, artist, album_name, duration) values
	('Hey Ma', 'J Balvin', 'Форсаж 8', 3.1),
	('Im OK', 'Little Big', 'Single', 3),
	('Топский Павел', 'Boulevard Depo', 'OTRICALA', 2.5),
	('Низкий', 'DK', 'SYNONIM', 3.2),
	('Номера', 'ЛСП', 'ЁП', 2.4),
	('Заряженный', 'GSPD', 'МYЗЛО', 3.5),
	('Hurricane', 'Escimo Callboy', 'Rehab', 3.4)
	;

create or replace view mix2 as
select song_name, artist, album_name 
from mix
order by artist;

select * from mix2;

drop table if exists recent;
create table recent(
	artist varchar(50),
	album_name varchar(50)
);

insert into recent values
	('Сёстры', 'Когда били волны'),
	('LIZER', 'Молодость'),
	('Монеточка', 'Декоративно-прикладное искусство'),
	('КУОК', 'КРАСНОСТЬ'),
	('Разные исполнители', 'Карнавала.Нет'),
	('SLAVA MARLOW', 'Артём'),
	('Би-2', 'Нечётный воин'),
	('Gorillaz', 'Song Machine'),
	('Ghostmane', 'ANTI-ICON')
	;

delimiter \\
drop procedure if exists aud\\
create procedure aud()
begin
	select count(*) from songs;
end\\

call aud\\
















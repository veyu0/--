DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50)
    email VARCHAR(255),
 	password_hash VARCHAR(255),
	phone BIGINT UNSIGNED UNIQUE, 
	
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
	
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- РїРѕРєР° СЂР°РЅРѕ, С‚.Рє. С‚Р°Р±Р»РёС†С‹ media РµС‰Рµ РЅРµС‚
);


DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- РјРѕР¶РЅРѕ Р±СѓРґРµС‚ РґР°Р¶Рµ РЅРµ СѓРїРѕРјРёРЅР°С‚СЊ СЌС‚Рѕ РїРѕР»Рµ РїСЂРё РІСЃС‚Р°РІРєРµ

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL, -- РёР·РјРµРЅРёР»Рё РЅР° СЃРѕСЃС‚Р°РІРЅРѕР№ РєР»СЋС‡ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
    -- `status` TINYINT(1) UNSIGNED, -- РІ СЌС‚РѕРј СЃР»СѓС‡Р°Рµ РІ РєРѕРґРµ С…СЂР°РЅРёР»Рё Р±С‹ С†РёС„РёСЂРЅС‹Р№ enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, -- РјРѕР¶РЅРѕ Р±СѓРґРµС‚ РґР°Р¶Рµ РЅРµ СѓРїРѕРјРёРЅР°С‚СЊ СЌС‚Рѕ РїРѕР»Рµ РїСЂРё РѕР±РЅРѕРІР»РµРЅРёРё
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)-- ,
    -- CHECK (initiator_user_id <> target_user_id)
);
-- С‡С‚РѕР±С‹ РїРѕР»СЊР·РѕРІР°С‚РµР»СЊ СЃР°Рј СЃРµР±Рµ РЅРµ РѕС‚РїСЂР°РІРёР» Р·Р°РїСЂРѕСЃ РІ РґСЂСѓР·СЊСЏ
ALTER TABLE friend_requests 
ADD CHECK(initiator_user_id <> target_user_id);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX communities_name_idx(name), -- РёРЅРґРµРєСЃСѓ РјРѕР¶РЅРѕ РґР°РІР°С‚СЊ СЃРІРѕРµ РёРјСЏ (communities_name_idx)
	foreign key (admin_user_id) references users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- С‡С‚РѕР±С‹ РЅРµ Р±С‹Р»Рѕ 2 Р·Р°РїРёСЃРµР№ Рѕ РїРѕР»СЊР·РѕРІР°С‚РµР»Рµ Рё СЃРѕРѕР±С‰РµСЃС‚РІРµ
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name VARCHAR(255), -- Р·Р°РїРёСЃРµР№ РјР°Р»Рѕ, РїРѕСЌС‚РѕРјСѓ РІ РёРЅРґРµРєСЃРµ РЅРµС‚ РЅРµРѕР±С…РѕРґРёРјРѕСЃС‚Рё
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    -- file blob,    	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    -- PRIMARY KEY (user_id, media_id) вЂ“ РјРѕР¶РЅРѕ Р±С‹Р»Рѕ Рё С‚Р°Рє РІРјРµСЃС‚Рѕ id РІ РєР°С‡РµСЃС‚РІРµ PK
  	-- СЃР»РёС€РєРѕРј СѓРІР»РµРєР°С‚СЊСЃСЏ РёРЅРґРµРєСЃР°РјРё С‚РѕР¶Рµ РѕРїР°СЃРЅРѕ, СЂР°С†РёРѕРЅР°Р»СЊРЅРµРµ РёС… РґРѕР±Р°РІР»СЏС‚СЊ РїРѕ РјРµСЂРµ РЅРµРѕР±С…РѕРґРёРјРѕСЃС‚Рё (РЅР°РїСЂ., РїСЂРѕРІРёСЃР°СЋС‚ РїРѕ РІСЂРµРјРµРЅРё РєР°РєРёРµ-С‚Рѕ Р·Р°РїСЂРѕСЃС‹)  

/* РЅР°РјРµСЂРµРЅРЅРѕ Р·Р°Р±С‹Р»Рё, С‡С‚РѕР±С‹ РїРѕР·РґРЅРµРµ СѓРІРёРґРµС‚СЊ РёС… РѕС‚СЃСѓС‚СЃС‚РІРёРµ РІ ER-РґРёР°РіСЂР°РјРјРµ
    , FOREIGN KEY (user_id) REFERENCES users(id)
    , FOREIGN KEY (media_id) REFERENCES media(id)
*/
);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
 





CREATE DATABASE tahona;

CREATE TABLE users(
user_id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
password VARCHAR(50) NOT NULL,
place_id INTEGER UNSIGNED,
name VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
gender ENUM('M','F','ND') NOT NULL,
birthdate DATETIME,
phone VARCHAR(30) NOT NULL,
address_id INTEGER UNSIGNED,
status TINYINT(1) NOT NULL DEFAULT 1,
permissions ENUM('yes','no') NOT NULL
);

INSERT INTO  users(password,place_id,name,lastname,
gender,birthdate,phone,address_id,permissions)
VALUES ('ab01cd1321',1,'Victor Hugo','Morales Martinez','M',
	'1999-04-05',5541174617,1,'yes');

CREATE TABLE clients(
	client_id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	lastname VARCHAR(30) NOT NULL,
	address_id INTEGER UNSIGNED,
	phone VARCHAR(30) NOT NULL,
	email VARCHAR(30) UNIQUE
);

INSERT INTO clients(name,lastname,address_id,phone,email)
VALUES ('Rodrigo','Vega',2,'5512345678','royvega@gmail.com');

CREATE TABLE products (
	product_id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	price DOUBLE(6,2) NOT NULL DEFAULT 10.0,
	size VARCHAR(60) NOT NULL DEFAULT 'ND',
	weigth DOUBLE(5,1) NOT NULL DEFAULT 1.5,
	image_url VARCHAR(500),
	category VARCHAR(500)
);
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

INSERT INTO  users(password,place_id,name,lastname,
gender,birthdate,phone,address_id,permissions)
VALUES ('pinguin',2,'Rodrigo','Vega','M',
	'1998-05-05',5534657821,1,'no');

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

INSERT INTO products(name,price,size,weigth,image_url,category)
VALUES ('Pavo',750.00,'GRANDE',0,'','');

CREATE TABLE places (
place_id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
name VARCHAR(500) NOT NULL,
address_id INTEGER UNSIGNED
 );

INSERT INTO places(name,address_id)
VALUES ('La Tahona Montevideo',2);

CREATE TABLE address (
	address_id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	delegacion VARCHAR(100),
	colonia VARCHAR(100),
	calle VARCHAR(100),
	numero_ext VARCHAR(100),
	numero_int VARCHAR(100)
);

INSERT INTO address(delegacion,colonia,calle,numero_ext,numero_int)
VALUES ('Nezahualcoyotl','Metropolitana 2da Seccion','Ex convento de Churubusco',133,0),
('Gustavo A. Madero','Lindavista','Av. Montevideo',290,0);

SELECT u.name,a.delegacion,a.colonia,a.calle,a.numero_ext,a.numero_int
FROM users AS u
JOIN address AS a
ON u.address_id = a.address_id;

CREATE TABLE purchases(
purchase_id INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
place_id INTEGER UNSIGNED,
client_id INTEGER UNSIGNED,
product_id INTEGER UNSIGNED,
user_id INTEGER UNSIGNED,
`time_pedido` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'yyyy-mm-dd hh:mm:ss',
`time_entrega` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
total DOUBLE(6,2),
cobro DOUBLE(6,2),
adeudo DOUBLE(6,2),
status_pago ENUM('Adeudo','Cobrado') NOT NULL DEFAULT 'adeudo',
status_entrega ENUM('Pendiente','Entregado') NOT NULL DEFAULT 'Pendiente',
observaciones TEXT
);

INSERT INTO purchases(place_id,client_id,product_id,user_id,observaciones)
VALUES(1,1,1,1,'Funciona');

SELECT pu.purchase_id, pl.place_id , c.name AS 'Nombre Cliete',
p.name AS 'Nombre Produco' 
,p.price ,
pu.status_pago, pu.status_entrega, pu.time_pedido 
FROM purchases AS pu 
JOIN places AS pl 
ON pu.place_id = pl.place_id
JOIN clients AS c
ON pu.client_id = c.client_id
JOIN products AS p
ON pu.product_id = p.product_id
JOIN users AS u 
ON pu.user_id = u.user_id;
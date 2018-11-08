create database pruebas;

use pruebas;

create table Usuario(
	id_usuario integer Primary Key not null Auto_Increment,
    nombre_usuario varchar(30),
    telefono varchar(30));

create table Producto(
	id_producto integer Primary Key not null Auto_Increment,
    nombre_producto varchar(30),
    precio int(10),
    tamaño varchar(30),
    peso int(10),
    tipo varchar(50));
    
    
create table Compra(
	id_compra integer Primary Key not null Auto_Increment,
    id_usuario integer,
    id_producto integer,
    foreign key (id_usuario) references Usuario(id_usuario),
    foreign key (id_producto) references Producto(id_producto));
    
insert into Producto values(
	1, 'Pavo',2000,'Grande',2,'Grande'); 
    

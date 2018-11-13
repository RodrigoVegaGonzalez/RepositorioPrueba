CREATE TABLE IF NOT EXISTS books (
	book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	author_id INTEGER UNSIGNED,
	title VARCHAR(100) NOT NULL,
	year INTEGER UNSIGNED NOT NULL DEFAULT 1900,
	language VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
	cover_url VARCHAR(500),
	price DOUBLE(6,2) NOT NULL DEFAULT 10.0,
	sellable TINYINT (1) DEFAULT 1,
	copies INTEGER NOT NULL DEFAULT 1,
	description TEXT  
);

CREATE TABLE IF NOT EXISTS authors (
    author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(3)
);

CREATE TABLE clients (
   `client_id` INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(50) NOT NULL,
   `email` VARCHAR(50) NOT NULL UNIQUE,
    birthdate DATETIME,
    gender ENUM('M', 'F', 'ND') NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'yyyy-mm-dd hh:mm:ss',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS operations(
    operation_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    book_id INTEGER UNSIGNED,
    client_id INTEGER UNSIGNED,
    `type` ENUM('Vendido', 'Prestado', 'Devuelto') NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'yyyy-mm-dd hh:mm:ss',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    finished TINYINT(1) NOT NULL 
);

INSERT INTO tabla(COLUMNAS*) VALUES(Valores)

INSERT INTO authors(author_id,name,nationality)
VALUES ('','Juan Rulfo','MEX');

INSERT INTO authors(name,nationality)
VALUES ('Gabriel Garcìa Màrquez','COL');

INSERT INTO authors (name,nationality)
VALUES ('','Juan Gabriel Vasquez','COL');

INSERT INTO authors(name,nationality)
VALUES ('Julio Cotàzar','ARG'),
    ('Isabel Allende','CHI'),
    ('Octavio Paz','MEX'),
    ('Juan Carlos Onetti','URU');


INSERT INTO  clients (name,email,birthdate,gender,active)
VALUES
('0','Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1),
('0','Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1),
('0','Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1),
('0','Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1),
('0','Pablo Saavedra','Pablo.93733268B@random.names','1960-07-21','M',1),
('0','Marta Carrillo','Marta.55741882W@random.names','1981-06-15','F',1);


INSERT INTO  clients (name,email,birthdate,gender,active)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
ON DUPLICATE KEY UPDATE active = VALUES(active);

INSERT INTO books (title,author_id)
VALUES ('El Laberinto de la soledad',6);

INSERT INTO books (title, author_id, `year`)
VALUES('Vuelta al Laberinto de la soledad',
    (SELECT author_id FROM authors
    WHERE name = 'Octavio PAZ' LIMIT 1), 1960);

SELECT name, email,gender FROM clientes
WHERE gender = 'F';

SELECT name, year(now())-year(birthdate) from clients; 

SELECT * FROM clients WHERE `name` LIKE '%illo%';


SELECT name, email,YEAR(NOW())-YEAR(birthdate),gender FROM clients WHERE gender='F' AND name LIKE '%Lop%';

//Dale nombre a una tabla creada con 'AS' ejem. ' YEAR(NOW())-YEAR(birthdate) AS edad'
SELECT name, email, YEAR(NOW())-YEAR(birthdate) AS edad,gender FROM clients WHERE gender='F' AND name LIKE '%Lop%';

//Contar en nùmero de datos de la tabla
SELECT COUNT(*) FROM authors;

SELECT * FROM authors WHERE author_id > 0 and author_id <=5;


//INNER JOIN que muestra el nombre del autor y el id del libro asi como el nombre de el libro correspondiente,
donde el id del autor va del 1 al 5

SELECT b.book_id , a.author_id, b.title FROM books as b JOIN authors as a on a.author_id = b.author_id WHERE a.author_id BETWEEN 1 AND 5;

//Muestra el nombre del autor y el nombre de su libro; si el nombre del autor contiene 'Julio' en su nombre
SELECT a.name, b.title FROM books as b JOIN authors as a on a.author_id = b.author_id WHERE a.name LIKE '%Julio%';

SELECT c.name, b.title, t.type FROM transactions AS t JOIN books AS b on t.book_id = b.book_id
JOIN clients AS c on t.client_id = c.client_id;

ALTER TABLE transactions MODIFY COLUMN `type` ENUM ('lend', 'return','sell') NOT NULL;

INSERT INTO transactions (transaction_id,book_id,client_id,`type`,`finished`)
VALUES (1,12,34,'sell',1),
(2,54,87,'lend',0),
(3,3,14,'sell',1),
(4,1,54,'sell',1),
(5,12,81,'lend',1),
(6,12,81,'return',1),
(7,87,29,'sell',1);


SELECT c.name, b.title, a.name, t.type FROM transactions AS t 
JOIN books AS b on t.book_id = b.book_id
JOIN clients AS c on t.client_id = c.client_id
JOIN authors AS a on b.author_id = a.author_id 
WHERE c.gender = 'M' and t.type IN ('sell','lend');

SELECT b.title, a.name FROM authors as a, books as b where a.author_id = b.author_id;

SELECT b.title, a.name FROM books as b INNER JOIN authors as a on a.author_id = b.author_id
limit 10;

SELECT a.author_id, a.name, a.nationality, b.title FROM authors
as a JOIN books as b on b.author_id = a.author_id WHERE a.author_id BETWEEN 1 and 5
ORDER BY a.author_id;

SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) FROM authors
as a LEFT JOIN books as b on b.author_id = a.author_id WHERE a.author_id BETWEEN 1 and 5
GROUP BY a.author_id
ORDER BY a.author_id;

UPDATE tabla SET [column] where [condiciones] LIMIT 1;

UPDATE clients SET active = 0  where client_id = 80 LIMIT 1;

UPDATE clients
SET active = 0 where client_id in(1,6,8,27)
OR NAME like '%Lopez%';

¿Què nacionalidades hay?

    SELECT DISTINCT nationality FROM authors ORDER BY nationality;

    ¿Cuantos escritores hay de cada nacionalidad?
    SELECT nationality, COUNT(author_id) AS c_authors FROM authors GROUP BY nationality
    ORDER BY c_authors DESC, nationality;

    SELECT nationality, COUNT(author_id) AS c_authors FROM authors 
    WHERE nationality IS NOT NULL 
    AND nationality NOT IN ('RUS','AUT')
    GROUP BY nationality
    ORDER BY c_authors DESC, nationality ;

    ¿Cuantos libros hay de cada nacionalidad?
    ¿Cual es el promedio/desviacion standar del precio de libros?

    SELECT nationality, COUNT(book_id),AVG(price) AS promedio , STDDEV(price) AS std
    FROM books as b JOIN authors as a ON a.author_id = b.author_id
    GROUP BY nationality
    ORDER BY promedio DESC;
    ¿idem, pero por nacionalidad?
    ¿Cual es el precio maximo/minimo de un libro?

    SELECT a.nationality, MAX(price), MIN(price) from books as b 
    JOIN authors AS a
    ON a.author_id = b.author_id
    GROUP BY nationality;


    ¿Como quedaria el reporte de prestamos?

    SELECT c.name, t.type, b.title, a.name,
    CONCAT(a.name ," ","(",a.nationality,")") as autor,
    CONCAT(TO_DAYS(NOW()) - TO_DAYS(t.created_at)," days ago")
    FROM transactions AS t 
    LEFT JOIN clients AS c
    ON c.client_id = t.client_id
    LEFT JOIN books AS b
    ON b.book_id = t.book_id
    LEFT JOIN authors AS a
    ON b.author_id = a.author_id;

    //UPDATE

    UPDATE [tabla] SET [nuevo valor]
    WHERE [condiciones]
    LIMIT 1 ;


    UPDATE clients SET email='javier@gmail.com'
    WHERE client_id = 7 OR client_id = 9;

    //DELETE
    //DELETE FROM authors// Forma incorrecta por que falta el WHERE

    DELETE FROM authors WHERE author_id = 35 limit 1;

    //Limit = 1 para disminuir el riego de perdida

SUPER QUERYS
 SELECT sellable ,COUNT(book_id) FROM books;
 SELECT sellable, COUNT(book_id) FROM books GROUP BY sellable;
  SELECT sellable ,SUM(price*copies) FROM books GROUP BY sellable;

SELECT COUNT(book_id), 
SUM(IF(year<1950,1,0)) AS 'Menor a 1950' ,
SUM(IF(year<1950,0,1)) AS 'Mayor a 1950' ,
SUM(IF(year >= 1990 and year < 2000, 1,0)) AS 'Menor a 2000'
FROM books GROUP BY book_id;

SELECT nationality , COUNT(book_id), 
SUM(IF(year<1950,1,0)) AS 'Menor a 1950' ,
SUM(IF(year<1950,0,1)) AS 'Mayor a 1950' ,
SUM(IF(year>= 1990 and year < 2000, 1,0)) AS 'Menor a 2000'
FROM books AS b 
JOIN authors AS a 
on a.author_id = b.author_id
WHERE a.nationality IS NOT NULL GROUP BY a.nationality;
INSERT INTO usuario(id_usuario,nombre_usuario,telefono)
VALUES (0,'Victor Hugo',5517894633),
	(0,'Antonio',5512345678),
	(0,'Roy Vega',5517893);

INSERT INTO compra (id_usuario,id_producto) values (1,1);

SELECT c.id_compra , u.nombre_usuario, p.nombre_producto FROM compra as c JOIN usuario as u JOIN producto as p on c.id_usuario = u.id_usuario and c.id_producto = p.id_producto;


INSERT INTO producto(nombre_producto,precio,tamaño,peso,tipo)
VALUES ('Lomo',1600,'Pequeño',1,'Pequeño'),
	('Romeritos',1700,'Pequeño',2,'Pequeño'),
	('Pierna',3000,'Grande',4,'Grande');


	INSERT INTO compra (id_usuario,id_producto) values (2,2),
	(3,4),
	(3,3),
	(3,1),
	(1,2),
	(2,4),
	(1,3);

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


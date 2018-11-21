<?php
require __DIR__ . '/autoload.php'; //Nota: si renombraste la carpeta a algo diferente de "ticket" cambia el nombre en esta línea
use Mike42\Escpos\Printer;
use Mike42\Escpos\EscposImage;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;

/*
	Este ejemplo imprime un
	ticket de venta desde una impresora térmica
*/


/*
	Una pequeña clase para
	trabajar mejor con
	los productos
	Nota: esta clase no es requerida, puedes
	imprimir usando puro texto de la forma
	que tú quieras
*/

/*
	Vamos a simular algunos productos. Estos
	podemos recuperarlos desde $_POST o desde
	cualquier entrada de datos. Yo los declararé
	aquí mismo
*/


/*
	Aquí, en lugar de "POS-58" (que es el nombre de mi impresora)
	escribe el nombre de la tuya. Recuerda que debes compartirla
	desde el panel de control
*/




$user = "root";
$pass = "n0m3l0";  // en mi caso tengo contraseña pero en casa caso introducidla aquí.
$servidor = "localhost";
$basededatos = "tahona";

$PDO = new PDO("mysql:dbname=tahona;host=127.0.0.1","root","n0m3l0");

$id = $_POST['hdnId'];
$tamano = $_POST['hdnTamano'];
$nombreProducto = $_POST['hdnNombreProducto'];
$nombreCliente = $_POST['hdnNombreCliente'];
$telefono = $_POST['hdnTel'];
$orderTime = $_POST['hdnOrderTime'];
$deliverTime = $_POST['hdnDeliverTime'];
$onAccount = $_POST['hdnAcuenta'];
$inDebt = $_POST['hdnTotal'];
$payment_status = '';
$deliver_status = 'Pendiente';

echo "ID: $id <br>";
echo "Tamaño: $tamano <br>";
echo "Order Time: $orderTime <br>";
echo "Deliver Time: $deliverTime <br>";
echo "Nombre Cliente: $nombreCliente <br>";
echo "Nombre Producto: $nombreProducto <br>";
echo "A cuenta: $onAccount <br>";
echo "En deuda: $inDebt <br>";


//Condicional para Payment_status. Deliver_Status por default es Pendiente
if($inDebt == 0) {
	$payment_status = 'Cobrado';
} else {
	if($onAccount < $inDebt)
		$payment_status = 'Adeudo';
}


//* Inserción en la base de datos*/
$stmt = $PDO->prepare("INSERT INTO purchases(
											client_name,
											product_id,
											on_account,
											in_debt,
											order_time,
											deliver_time,
											payment_status,
											deliver_status)
						VALUES(
								:clientName,
								:productId,
								:onAccount,
								:inDebt,
								:orderTime,
								:deliverTime,
								:paymentStatus,
								:deliverStatus)");

$rs = $stmt->execute(array(
					"clientName"=> $nombreCliente, 
					"productId"=> $id,
					"onAccount"=> $onAccount,
					"inDebt"=> $inDebt,
					"orderTime"=> $orderTime,
					"deliverTime" => $deliverTime,
					"paymentStatus" => $payment_status,
					"deliverStatus" => $deliver_status));


var_dump($rs);

$nombre_impresora = "BIXOLON SRP-350plusIII"; 
$connector = new WindowsPrintConnector($nombre_impresora);
$printer = new Printer($connector);


$conexion = mysqli_connect( $servidor, $user, $pass);

$db = mysqli_select_db( $conexion, $basededatos );

$sentencia = "SELECT pu.purchases_id, pu.client_name , p.product_id ,p.price,p.name,pu.on_account,pu.in_debt,pu.order_time,pu.deliver_time FROM purchases AS pu
JOIN products AS p ON p.product_id = pu.product_id Order BY pu.purchases_id DESC limit 1;";

$resultado = mysqli_query( $conexion, $sentencia ) or die ( "Algo ha ido mal en la consulta a la base de datos"); 


while ($ticket = mysqli_fetch_array( $resultado))
{


# Vamos a alinear al centro lo próximo que imprimamos
$printer->setJustification(Printer::JUSTIFY_CENTER);
$printer->text("FOLIO" . "\n");
$printer->text($ticket['purchases_id'] . "\n");
$printer->text("\n");
/*
	Intentaremos cargar e imprimir
	el logo
*/
try{
	$logo = EscposImage::load("images/drones.png", false);
    $printer->bitImage($logo);
}catch(Exception $e){/*No hacemos nada si hay error*/}

$printer->text("\n");
$printer->text("PEDIDO" . "\n");
$printer->text("\n");
$printer->text("VENTA" . "\n");
$printer->text("\n");
$printer->text("NOMBRE DE LA SUCURSAL" . "\n");

$printer->setJustification(Printer::JUSTIFY_LEFT);	

$printer->text("\n");
$printer->text("HORA y FECHA DE LA COMPRA:" . "\n");
$printer->text($ticket['order_time'] . "\n");

$printer->text("\n");
$printer->text("HORA y FECHA DE LA ENTREGA:" . "\n");
$printer->text($ticket['deliver_time']. "\n");
/*
	Ahora vamos a imprimir un encabezado
*/



/*$conexion = mysqli_connect( $servidor, $user, 
	$pass);*/



//$db = mysqli_select_db( $conexion, $basededatos );



$printer->setJustification(Printer::JUSTIFY_CENTER);	
$printer->text("\n");
$printer->text("\n");
$printer->text("Producto" . "\n");
$printer->text("\n");

$printer->setJustification(Printer::JUSTIFY_LEFT);	
$printer->text($ticket['name'] . "\n");

$printer->setJustification(Printer::JUSTIFY_RIGHT);
$printer->text("$".$ticket['price']. "\n");





$printer->setJustification(Printer::JUSTIFY_CENTER);
$printer->text("--------------------------------\n");
$printer->setJustification(Printer::JUSTIFY_RIGHT);	
$printer->text("Total:". "  "); 

$printer->setJustification(Printer::JUSTIFY_RIGHT);
$printer->text("$". $ticket['price']);

$printer->text("\n");
$printer->setJustification(Printer::JUSTIFY_RIGHT);	
$printer->text("A cuenta:". "  "); 

$printer->setJustification(Printer::JUSTIFY_RIGHT);
$printer->text("$". $ticket['on_account']);

$printer->text("\n");
$printer->setJustification(Printer::JUSTIFY_RIGHT);	
$printer->text("Saldo:". "  "); 


$printer->setJustification(Printer::JUSTIFY_RIGHT);
$printer->text("$". $ticket['in_debt']);

$printer->text("\n");

}


$consulta_usuarios = "SELECT * FROM users WHERE name LIKE '%ic%'";



$resultado = mysqli_query( $conexion, $consulta_usuarios ) or die ( "Algo ha ido mal en la consulta a la base de datos"); 

$usuario = mysqli_fetch_array( $resultado );


$printer->setJustification(Printer::JUSTIFY_CENTER);
$printer->text("\n");
$printer->text("*NOTA: En piernas y en lomos," . "\n");
$printer->text("la nota no se totaliza , el precio" . "\n");
$printer->text("marcado, indica el precio por kilo." . "\n");
$printer->text("\n");
$printer->text("Te atendio: " . "\n");
$printer->text($usuario['name']. "\n");


$printer->text("\n");
$printer->text("DIRECCION DE LA SUCURSAL" . "\n");
$printer->text("TELEFONO DE LA SUCURSAL" . "\n");
$printer->text("\n");

/*
	Ahora vamos a imprimir los
	productos
*/

# Para mostrar el total


/*
	Terminamos de imprimir
	los productos, ahora va el total
*/



/*
	Podemos poner también un pie de página
*/


/*Alimentamos el papel 3 veces*/
$printer->feed(3);

/*
	Cortamos el papel. Si nuestra impresora
	no tiene soporte para ello, no generará
	ningún error
*/
$printer->cut();

/*
	Por medio de la impresora mandamos un pulso.
	Esto es útil cuando la tenemos conectada
	por ejemplo a un cajón
*/
$printer->pulse();

/*
	Para imprimir realmente, tenemos que "cerrar"
	la conexión con la impresora. Recuerda incluir esto al final de todos los archivos
*/
$printer->close();
?>
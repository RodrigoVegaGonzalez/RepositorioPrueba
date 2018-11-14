<?php
header('Content-Type: application/json');
$pdo= new PDO("mysql:dbname=base_pruebas_php;host=127.0.0.1","root","n0m3l0");

$accion = (isset($_GET['accion']))?$_GET['accion']:'leer';

//echo $accion;


switch ($accion) {
  case 'agregar':

    $sentenciaSQL = $pdo->prepare("INSERT INTO eventos
      (title,descripcion,color,textcolor,start,end)
    VALUES(:title,:descripcion,:color,:textColor,:start,:end)");


    $respuesta=$sentenciaSQL->execute(array(
      "title"=>$_POST['title'],
      "descripcion"=>$_POST['descripcion'],
      "textColor"=>"#FFFFFF",
      "color"=>$_POST['color'],
      "start"=>$_POST['start'],
    //  "end"=>"2018-11-27 10:30:00"
        "end"=>$_POST["end"]



    // $respuesta=$sentenciaSQL->execute(array(
    //   "title"=>$_POST['title'],
    //   "descripcion"=>$_POST['descripcion'],
    //   "color"=>$_POST ['color'],
    //   "textColor"=>$_POST['textColor'],
    //   "start"=>$_POST['start'],
    //   "end"=>$_POST['end']

    ))  ;

      print json_encode($respuesta);


    break;
    case 'modificar':
    $sentenciaSQL = $pdo->prepare("UPDATE eventos SET
    title=:title,
    color=:color,
    descripcion=:descripcion,
    start=:start WHERE ID=:ID");

    $respuesta=$sentenciaSQL->execute(array(
      "ID"=>$_POST['id'],
      "title"=>$_POST['title'],
      "descripcion"=>$_POST['descripcion'],
      "color"=>$_POST['color'],
      "start"=>$_POST['start']
    ));


//>$_POST['color']
      print json_encode($respuesta);

      break;

  case 'eliminar':
   //$sentenciaSQL = $pdo->prepare("delete from Eventos where id=19");
  // $id= $_POST["id"];
  $respuesta = false;
  if(isset($_POST['id'])){
      $sentenciaSQL = $pdo->prepare("delete from eventos where id=:ID");
        $respuesta=$sentenciaSQL->execute(array("ID"=>$_POST['id']));

  }
  print json_encode($respuesta);




  break;

  default:

  $sentenciaSQL= $pdo->prepare("select * from Eventos");
  $sentenciaSQL->execute();
  $resultado = $sentenciaSQL->fetchAll(PDO::FETCH_ASSOC);
  print json_encode($resultado);

    break;
}
//$con->close();

 ?>

<?php
    $TipoRegistro = $_POST['TipoRegistro'];
    $TipoUnidad = $_POST['TipoUnidad'];
    $TipoUnidadInterna = $_POST['TipoUnidadInterna'];
    $Full = $_POST['Full'];
    $Economico = $_POST['Economico'];
    $Remolque1 = $_POST['Remolque1'];
    $Remolque2 = $_POST['Remolque2'];
    $NRefacciones = $_POST['NRefacciones'];
    $Observaciones = $_POST['Observaciones'];
    $db = mysqli_connect('localhost','kofuz01','Xcape15948','entradasysalidas');
    $query = "INSERT INTO entradadsysalidasforsis (TipoRegistro, TipoUnidad, TipoUnidad1,Full,Economico,Remolque1,Remolque2,NRefacciones,Observaciones,Observaciones)
     VALUES ('$TipoRegistro', '$TipoUnidad', '$TipoUnidadInterna','$Full','intval($Economico)','$Remolque1','$Remolque2','$NRefacciones','$Observaciones')";

    try{
            echo json_encode("Success");
    }catch(Exception $e){
        echo json_encode($e);
    }

?>
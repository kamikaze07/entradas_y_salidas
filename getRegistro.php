<?php
    $Id_Registro = $_POST['Id_Registro'];
    $db = mysqli_connect('localhost','kofuz01','Xcape15948','entradasysalidas');
    $result = mysqli_query($db, "SELECT * FROM entradasysalidasforsis where Id_Entrada = '$Id_Entrada'");
    $list = array();
    if($result){
        while($row = mysqli_fetch_assoc($result)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
?>
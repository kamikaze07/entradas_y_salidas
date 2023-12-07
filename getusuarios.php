<?php
    $db = mysqli_connect('localhost','kofuz01','Xcape15948','sicre');
    $sql = "SELECT * FROM usuarios";
    $result = mysqli_query($db, $sql);
    $array = array();
    try {
        while($file = mysqli_fetch_array ($result)){
            array_push($array,$file["nombre_usu"]);
        }
    }catch(Exception $e){
        echo $e;
    }
    $json = json_encode($array);
    echo $json;
    
?>
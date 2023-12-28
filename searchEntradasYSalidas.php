<?php
    $search = $_POST['search'];
    $db = mysqli_connect('localhost','kofuz01','Xcape15948','entradasysalidas');
    $result = mysqli_query($db, "SELECT TipoRegistro,TipoUnidad,TipoUnidad1,Economico,Fecha FROM entradasysalidasforsis where Economico like '%'$search'%' order by Fecha Limit 25");
    $list = array();
    if($result){
        while($row = mysqli_fetch_assoc($result)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
?>
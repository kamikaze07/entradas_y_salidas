<?php
    $search = $_POST['search'];
    $db = mysqli_connect('localhost','kofuz01','Xcape15948','entradasysalidas');
    $result = mysqli_query($db, "SELECT TipoRegistro,TipoUnidad,TipoUnidad1,Economico,Fecha FROM entradasysalidasforsis 
    where TipoRegistro like '%'$search'%' 
    OR TipoUnidad like '%'$search'%' 
    OR TipoUnidad1 like '%'$search'%' 
    OR Full like '%'$search'%'
    OR Economico like '%'$search'%'
    OR Empleado like '%'$search'%'
    OR Remolque1 like '%'$search'%'
    OR Remolque2 like '%'$search'%'
    OR NRefacciones like '%'$search'%'
    OR Observaciones like '%'$search'%'
    OR Fecha like '%'$search'%'
    order by Fecha Limit 25");
    $list = array();
    if($result){
        while($row = mysqli_fetch_assoc($result)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
?>
<?php
    $db = mysqli_connect('localhost','kofuz01','Xcape15948','sicre');
    $username = $_POST['username'];
    $password = $_POST['password'];
    $passwordmd5 = md5($password);
    $sql = "SELECT * FROM usuarios WHERE nombre_usu = '".$username."' AND contrasena = '".$passwordmd5."'";
    $result = mysqli_query($db,$sql);
    $count = mysqli_num_rows($result);
    if($count == 1){
        echo json_encode("Success");
    }
    else{
        echo json_encode("Error");
    }
?>
<?php

class SessionModel {

    private $db;

    public function __construct() {
        require 'libs/SPDO.php';
        $this->db = SPDO::singleton();
    }

        /*
     * Se encarga de validar la sesion para el administrador, para poder ingresar a la seccion administrativa
     */
    public function validateSession($user_name, $password) {
        $query = $this->db->prepare("call sp_validate_session('$user_name','$password')");
        $query->execute();
        $result = $query->fetch();
        return $result;
    }
}

<?php

class AdminModel {

    private $db;

    public function __construct() {
        require 'libs/SPDO.php';
        $this->db = SPDO::singleton();
    }

    /*
     * El metodo de insertar los datos de un nuevo sitio turistico
    */
     public function insertSite($nombre,$direccion,$descripcion,$x,$y,$tipoPrecio,$lugarPreferencia,$tipoDestino,$tiempo,$tipoCamino,$categoria,$imagen) {
        $query = $this->db->prepare("call sp_insert('$tipoPrecio','$lugarPreferencia','$tipoDestino','$tiempo','$tipoCamino','$categoria','$nombre','$direccion','$descripcion','$x','$y','$imagen')");
        $query->execute();
        $result = $query->fetch();
        return $result;
    }

    /*
     * El metodo se encarga de eliminar un sitio a partir de usu id
     */
    public function deleteSite($id) {
        $query = $this->db->prepare("call sp_delete('$id')");
        $query->execute();
        $result = $query->fetch();
        return $result;
    }

    /*
     * El metodo se encarga de actualizar los datos de un sitio turistico registrado en el sistema
     */
    public function updateSite($nombre,$direccion,$descripcion,$x,$y,$tipoPrecio,$lugarPreferencia,$tipoDestino,$tiempo,$tipoCamino,$categoria,$imagen,$id) {
        $query = $this->db->prepare("call sp_update('$id','$tipoPrecio','$lugarPreferencia','$tipoDestino','$tiempo','$tipoCamino','$categoria','$nombre','$direccion','$descripcion','$x','$y','$imagen')");
        $query->execute();
        $result = $query->fetch();
        return $result;
    }

     /*
     * Se encarga de obtener todos los nombres de los sitios de la DB
     */
    public function allSitesName() {
        $query = $this->db->prepare("call sp_get_all_name_site()");
        $query->execute();
        $result = $query->fetchAll();
        return $result;
    }

    /*
     * El metodo se encarga de obtener los datos de un sitio turistico en especifico
     */
    public function getInformationSite($id) {
        $query = $this->db->prepare("call sp_get_destination('$id')");
        $query->execute();
        $result = $query->fetch();
        return $result;
    }

}

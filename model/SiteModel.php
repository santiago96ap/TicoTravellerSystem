<?php

class SiteModel {

    private $db;

    public function __construct() {
        require 'libs/SPDO.php';
        $this->db = SPDO::singleton();
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
     * Se encarga de obtener toda la informacion de un sitio turistico
      * de acuerod a su nombre buscado de la DB
     */
    public function getSiteInformation($name) {
        $query = $this->db->prepare("call sp_get_data_site_information('$name')");
        $query->execute();
        $result = $query->fetchAll();
        return $result;
    }
    
     /*
     * Se encarga de obtener toda la informacion de todos los sitios de la DB que pertenecen a la misma categoría que los datos actuales
     */
    public function getCategorySites($price, $preferencePlace, $destinationType, $time, $road) {
        $query = $this->db->prepare("call sp_recommend_destination('$price','$preferencePlace','$destinationType','$time','$road')");
        $query->execute();
        $result = $query->fetchAll();
        return $result;
    }

    /*
     * Se encarga de obtener toda la informacion de todos los sitios de la DB
     */
    public function getAllSites() {
        $query = $this->db->prepare("call sp_get_all_destinations()");
        $query->execute();
        $result = $query->fetchAll();
        return $result;
    }
}

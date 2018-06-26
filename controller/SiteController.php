<?php
class SiteController {

    private $positions = [];
    private $maxLenght=3;

    function __construct() {
        $this->view = new View();
    }
    
    function defaultAction() {
        $this->view->show("indexView.php");
    }

    /*****************************************APLICACIÓN ANDROID********************************************/

    /*
     * El metodo se encarga de obtener los nombres de todos los sitios turisticos de la base de datos
     */
    function allSitesName() {
        require 'model/SiteModel.php';
        $model = new SiteModel();
        $result = $model->allSitesName();      
        echo json_encode($result);
    }

    /*
     * El metodo se encarga de obtener toda la informacion relacionada a un sitio turistico
     * de acuerdo al nombre que el usuario ingreso en la busqueda en la aplicacion movil
     */
    function getSiteInformation() {
        require 'model/SiteModel.php';
        $model = new SiteModel();
        $result = $model->getSiteInformation($_REQUEST['name']);      
        echo json_encode($result);
    }
    
    /*
     * El metodo se encarga de obtener toda la informacion relacionada a todos los sitios 
     * turisticos alojados en la base de datos
     */
    function getCategorySites($price, $preferencePlace, $destinationType, $time, $road) {
        require 'model/SiteModel.php';
        $model = new SiteModel();
        $result = $model->getCategorySites($price, $preferencePlace, $destinationType, $time, $road);      
        return $result;
    }

    function getAllSites() {
        require 'model/SiteModel.php';
        $model = new SiteModel();
        $result = $model->getAllSites();      
        return $result;
    }

    /*El siguiente método es el encargado de realizar el cálculo según el algoritmo de Euclides.
     * El método recibe  arrays y recorre campo por campo cada uno de ellos.
     * Por cada posicion del arreglo A, se calcula su distancia con la misma posición del arreglo temporal.
     * Si el valor de una posicíón del arreglo es numérica se realiza el cálculo de la resta y el elevado al cuadrado según el algoritmo.
     * Si el valor No es numerico se utiliza la función de levenshtein para calcular la distancia entre palabras, que sería el valor numerico que necesita el algoritmo para elevarlo al cuadrado.
     * Finalmente se retorna la raiz cuadrada de la suma de todas las distancias de los valores de cada posicion del arreglo variales, con su misma posicion del arreglo temporal
     */
    function euclidenDistance($variables, $arrayTemp){
        $sum=0;
        for ($i = 0; $i < count($variables); $i++){
            if(!is_string($arrayTemp[$i])){
                $sum += pow(($arrayTemp[$i]-$variables[$i]),2);
            }else{
                $sum += pow((levenshtein($arrayTemp[$i], $variables[$i])), 2);
            }//if-else
        }//for
        return (sqrt($sum));
    }//euclidenDistances

    
    /*
     * El metodo es el encargado de gestionar todo lo relacionado a calcular la similitud de los datos ingresados 
     * por el usuario con los de las caracteristicas de los sitios turisticos alojados en la base de datos.
     * Logra obtener despues de aplicar el Algoritmo de Euclides los 3 sitios turisticos mas similares a las caracteristicas
     * ingresadas por el usuario, para despues retornarlos y enviarlos a la aplicacion movil
     */
    public function getSimilarity() {
        if(isset($_POST['price']) && isset($_POST['typeDestination']) && isset($_POST['roadType']) && isset($_POST['time']) && isset($_POST['preferencePlace'])){ 

            $price = $_POST['price'];
            $typeDestination =  $_POST['typeDestination'];
            $roadType = $_POST['roadType'];
            $time = $_POST['time'];
            $preferencePlace = $_POST['preferencePlace'];           
            $userData = array($price, $typeDestination, $roadType, $time, $preferencePlace);
            $sites = $this->getCategorySites($price, $preferencePlace, $typeDestination, $time, $roadType);
            foreach ($sites as $temp) {
                $valueSite = array($temp['price'], $temp['destination_type'], $temp['road_type'], $temp['travel_time'], $temp['preference_place']);
                $site = array($temp['id'], $temp['name'], $temp['address'], $temp['description'], $temp['x'], $temp['y'], $temp['image']);
                $distance = $this->euclidenDistance($userData, $valueSite);
                $this->order($site, $distance);
                unset($site);
                unset($valueSite);
            }//foreach

           $json=array();

            foreach ($this->positions as $datos2) {
                foreach ($datos2 as $datos3) {
                    if($datos3[0]!=NULL){
                        $result["id"]=$datos3[0];
                        $result["name"]=$datos3[1];
                        $result["address"]=$datos3[2];
                        $result["description"]=$datos3[3];
                        $result["x"]=$datos3[4];
                        $result["y"]=$datos3[5];
                        $result["image"]=$datos3[6];
                        array_push($json, $result);
                    }                  
                }
            }
            echo json_encode($json);
        }
    }//getAllSites
    
    /*
     * Actualiza  el arreglo que alberga las 3 mayores diferencias de acuerdo a los criterios ingresados por el usuario
     * y el valor obtenido en el algoritmo de Euclides, sustituyendo algun campo del arreglo si existe
     * una nueva diferencia de sitio turistico menor a alguna de las alojadas en el arreglo
     */

    function order($dataArray, $distancia){

        $temporal = array("valores"=>$dataArray, "distancia"=>$distancia);
        if (count($this->positions) < $this->maxLenght) {
            array_push($this->positions, $temporal);
        }else{
            usort($this->positions, $this->build_sorter('distancia'));
            if($distancia <= $this->positions[count($this->positions)-1]['distancia']){
                $this->positions[count($this->positions)-1] = $temporal;
            }//if
        }//else
        unset($temporal);
    }//euclidenDistances

    /*
     * Se encarga de ordenar un arreglo de acuerdo a su clave
     */
    function build_sorter($clave) {
        return function ($a, $b) use ($clave) {
            return strnatcmp($a[$clave], $b[$clave]);
        };
    }//build_sorter


    /*****************************APLICACIÓN WEB***************************/

    public function searchSite() {
        //if(isset($_REQUEST['name'])){       
            //$siteName = array($_REQUEST['name']);
            $siteName = array('parque nacional');
            $first = true;
            $numAnterior; $arrayTemp; $finalSite;
            $registros = $this->getAllSites();

            $numAnterior =0;
            foreach ($registros as $temp) {
                $arrayTemp = array($temp['name']);
                $num = $this->euclidenDistance($siteName, $arrayTemp);
                
                if($first){
                    $numAnterior = $num;
                    $finalSite = $temp;
                    $first = false;
                }else if($num <= $numAnterior){
                    $numAnterior = $num;
                    $finalSite = $temp;
                }//if
                unset($arrayTemp);
            }//foreach
            
            echo json_encode($finalSite);
       // }//if
    }//searchSite




    

}//class


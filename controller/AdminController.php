<?php
class AdminController {

    function __construct() {
        $this->view = new View();
    }
    
    function defaultAction() {
        $this->view->show("indexView.php");
    }

    /*
     * El metodo insertSite se encarga de realizar el proceso de insercion de los datos de un nuevo sitio turistico proveniente de la vista. 
     */
    function insertSite() {
        require 'model/AdminModel.php';
        $model = new AdminModel();

        $file = $_FILES['file'];
        $type = $file["type"];
        $UrlTemp = $file["tmp_name"];
        $folder = "public/img/";
        
        if ($type != 'image/jpg' && $type != 'image/jpeg' && $type != 'image/png' && $type != 'image/gif') {
            throw new Exception('');
        }else {
            $totalFiles = count(glob($folder . '{*.jpg,*.gif,*.png,*.jpeg}', GLOB_BRACE));
            $typeTemp = explode('/', $type);
            $src = $folder.$totalFiles.'.'.$typeTemp[1];
            move_uploaded_file($UrlTemp, $src);
        }
        
        $result = $model->insertSite(
            $_POST['nombre'],
            $_POST['direccion'],
            $_POST['descripcion'],
            $_POST['x'],
            $_POST['y'],
            $_POST['tipoPrecio'],
            $_POST['lugarPreferencia'],
            $_POST['tipoDestino'],
            $_POST['tiempo'],
            $_POST['tipoCamino'],
            $_POST['categoria'],
            $src
        );      
        echo json_encode($result);
    }

    /*
     * El metodo obtiene los nombres de todos los sitios registrados.
     */
	function updateDeleteSite() {
	   	require 'model/AdminModel.php';
        $model = new AdminModel();
        $result = $model->allSitesName();
        $this->view->show("ActModSitioView.php", $result);  
	} 

    /*
     * El metodo se encarga de obtener los nombres de todos los sitios turisticos de la base de datos
     */
	function listSite() {
	   	require 'model/AdminModel.php';
        $model = new AdminModel();
        $result = $model->allSitesName();
        $this->view->show("ListarSitioView.php", $result);  
	}     

    /*
     * El metodo se encarga de eliminar un registro especifico de la base de datos
     */
    function deleteSite() {

		require 'model/AdminModel.php';
        $model = new AdminModel();      
        $result = $model->deleteSite($_POST['id']);      
        echo json_encode($result);
    }

    /*
     * El metodo se encarga de actualizar los datos de un registro especifico
     */
    function updateSite() {
        require 'model/AdminModel.php';
        $model = new AdminModel();

        $file = $_FILES['file'];
        $type = $file["type"];
        $UrlTemp = $file["tmp_name"];
        $folder = "public/img/";
        
        if ($type != 'image/jpg' && $type != 'image/jpeg' && $type != 'image/png' && $type != 'image/gif') {
            throw new Exception('');
        }else {
            $totalFiles = count(glob($folder . '{*.jpg,*.gif,*.png,*.jpeg}', GLOB_BRACE));
            $typeTemp = explode('/', $type);
            $src = $folder.$totalFiles.'.'.$typeTemp[1];
            move_uploaded_file($UrlTemp, $src);
        }
        
        $result = $model->updateSite(
            $_POST['nombre'],
            $_POST['direccion'],
            $_POST['descripcion'],
            $_POST['x'],
            $_POST['y'],
            $_POST['tipoPrecio'],
            $_POST['lugarPreferencia'],
            $_POST['tipoDestino'],
            $_POST['tiempo'],
            $_POST['tipoCamino'],
            $_POST['categoria'],
            $src,
            $_POST['id']
        );      
        echo json_encode($result);
    }

    /*
     * El metodo se encarga de obtener la información de un sitio especificos
     */
    function getInformationSite() {
        require 'model/AdminModel.php';
        $model = new AdminModel();
        $result = $model->getInformationSite($_POST['id']);        
        echo json_encode($result);
    }

}//class


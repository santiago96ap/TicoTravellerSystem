<?php
class SessionController {

    function __construct() {
        $this->view = new View();
    }
    
    function defaultAction() {
        $this->view->show("indexView.php");
    }

    public function validateSession() {
        require 'model/SessionModel.php';
        $model = new SessionModel();
        $result = $model->validateSession($_POST['userName'], $_POST['pass']);
        if ($result['user_name'] != "") {      
            $response['result']="1";
        	echo json_encode($response);
        } else {
        	$response['result']="0";
        	echo json_encode($response);
        }
    }

}//class


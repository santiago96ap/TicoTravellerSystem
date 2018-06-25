<?php
class AdminController {

    function __construct() {
        $this->view = new View();
    }
    
    function defaultAction() {
        $this->view->show("indexView.php");
    }
}//class


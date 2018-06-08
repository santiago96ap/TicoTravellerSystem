<?php

require 'Config.php';
$config = Config::singleton();
$config->set('controllerFolder', 'controller/');
$config->set('modelFolder', 'model/');
$config->set('viewFolder', 'view/');

//$config->set('dbhost', '163.178.107.130');
//$config->set('dbname', 'db_task1_expert_systems_diego_cedeno_2018');
//$config->set('dbuser', 'laboratorios');
//$config->set('dbpass', 'UCRSA.118');

$config->set('dbhost', 'sql9.freemysqlhosting.net');
$config->set('dbname', 'sql9241265');
$config->set('dbuser', 'sql9241265');
$config->set('dbpass', '4UivGEeCx3');

//$config->set('dbhost', 'localhost');
//$config->set('dbname', 'db_task2_experts_diego_cedeno');
//$config->set('dbuser', 'root');
//$config->set('dbpass', 'root');

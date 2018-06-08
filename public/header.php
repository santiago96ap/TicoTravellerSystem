<?php
include_once 'public/head.php';
?>
    <header id="header" class="clear"> 
      <div id="logo">
        <h1><a href="index.html">Tarea 1 de Sistemas Expertos</a></h1>
      </div>
      <nav id="mainav" class="clear">
        <ul class="clear">
          <li class="active"><a href="?controller=Index&action=defaultAction">Inicio</a></li>
          <li><a class="drop" href="#">Opciones</a>
            <ul>
              <li><a href="?controller=Guess&action=showCalculateStyle">Calcular estilo de aprendizaje</a></li>
              <li><a href="?controller=Guess&action=showGuessGender">Adivinar G&eacute;nero</a></li>
              <li><a href="?controller=Guess&action=showGuessEnclosure">Adivinar Recinto</a></li>
              <li><a href="?controller=Guess&action=showGuessStyle">Adivinar estilo de aprendizaje</a></li>
              <li><a href="?controller=Guess&action=showGuessProfessor">Adivinar clasificaci&oacute;n de profesor</a></li>
              <li><a href="?controller=Guess&action=showGuessNet">Adivinar clasificaci&oacute;n de red</a></li>
            </ul>
          </li>
        </ul>
      </nav>
    </header>
  </div>
</div>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Autocomplete - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>

  var arraySitios = [];

  $(document).ready(function(){
      $.post("?controller=Site&action=allSitesName",null, function(data){
            var sitios = JSON.parse(data);
            
            for (var i = 0; i < sitios.length; i++) {
               arraySitios.push(sitios[i].name);
}
        });
  });

    $( function() {
    $( "#tags" ).autocomplete({
      source: arraySitios
    });
  } );

  </script>
</head>
<body>
 
<div class="ui-widget">
  <label for="tags">Tags: </label>
  <input id="tags">
</div>
 
 
</body>
</html>
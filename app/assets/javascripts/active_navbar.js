$(document).ready (function(){
  var url = document.URL;
  if (url.match(/periods/g)){
    $('.nav a:contains("Home")').parent().addClass('active');
  }
  if (url.match(/periods/all/g)){
    $('.nav a:contains("Outros períodos")').parent().addClass('active');
  }
});

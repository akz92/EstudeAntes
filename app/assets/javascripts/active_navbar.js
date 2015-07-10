$(document).on("page:change", function(){
  var pathname = document.location.pathname;
  if (pathname == "/"){
    $('.nav a:contains("Período Atual")').parent().addClass('active');
  }
  if (pathname == "/periods/all"){
    $('.nav a:contains("Outros períodos")').parent().addClass('active');
  }
});

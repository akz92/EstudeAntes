$(window).load(function(){
  $('.fluidHeight').each(function () {
    var eHeight = $(this).parent().innerHeight();
    $(this).outerHeight(eHeight);
});
});

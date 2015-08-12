$(document).ready(function() {
  $(window).bind('rails:flash', function(e, params) {
    //var translated_title = '';
    //switch(params.type) {
    //  case 'success':
    //    translated_title = 'sucesso';
    //    break;
    //  case 'error':
    //    translated_title = 'erro';
    //    break;
    //  default:
    //    translated_title = 'info';
    //}

    new PNotify({
      title: false,//translated_title,//params.type,
      buttons: {
        closer: false,
        sticker: false,
        closer_hover: false,
        labels: { close: 'Fechar' }
      },
      delay: 5000,
      mouse_reset: false,
      text: params.message,
      type: params.type
    });
  });
});

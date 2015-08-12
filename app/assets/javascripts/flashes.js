$(document).ready(function() {
  $(window).bind('rails:flash', function(e, params) {
    new PNotify({
      title: params.type,
      buttons: {
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

var Raxa = function() { };

Raxa.prototype.displayNotice = function(notice, duration) {
  var n = $(notice).hide();
  duration = duration || 3000;
  $('#notices').append(n);
  n.slideDown().delay(duration).slideUp('default', function() {
    $(this).remove();
  });
};

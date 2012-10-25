var Raxa = function() { };

Raxa.prototype.message_persist = 3000;
Raxa.prototype.init = function() {
  $('.notices').slideDown().delay(this.message_persist).slideUp('default', function() {
    $(this).remove();
  });
};

Raxa.prototype.displayNotice = function(notice, duration) {
  var n = $(notice).hide();
  duration = duration || this.message_persist;
  $('#notices').append(n);
  n.slideDown().delay(duration).slideUp('default', function() {
    $(this).remove();
  });
};

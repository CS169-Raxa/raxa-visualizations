var Screener = function() { };

Screener.prototype = new Raxa();

Screener.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.colourBars();
};

Screener.prototype.colourBars = function() {
  var color = d3.scale.linear()
    .domain([0, 50, 100])
    .range(["#116011", "#dd9022", "#bb4444"]);
  $('.bar').each(function(i, e) {
    e.style.backgroundColor = color($(e).data('percent'));
  });
};

$(document).ready(function() {
  screener = new Screener();
  screener.init();
});

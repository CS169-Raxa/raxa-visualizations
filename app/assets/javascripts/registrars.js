var Registrar = function() { };

Registrar.prototype = new Raxa();
Registrar.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initPerformanceHistory();
};

Registrar.prototype.initPerformanceHistory = function() {
  var data = $('#registration_history_graph').data('points');
  this.drawTimeGraph(d3.select('#registration_history_graph'), data);
};

$(document).ready(function() {
  registrar = new Registrar();
  registrar.init();
});

var Pharmacy = function() { };

Pharmacy.prototype = new Raxa();

Pharmacy.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initDOMListeners();
  this.initGraphs();
};

Pharmacy.prototype.initDOMListeners = function() {
  $('.details_container').hide();
  $('.info').bind('click', function() {
    $(this).next().find('.details_container').slideToggle();
  });

  this.initForms($('.drug_form'));

  $('.drug_form').on('submit', function() {
    return false;
  });
};

Pharmacy.prototype.initForms = function(forms) {
  forms.ajaxForm({
    success: function(data) {
      this.displayNotice(data.notice);
      var drugID = '#drug' + data.id;
      $(drugID).replaceWith(data.data);
      this.initForms($(drugID + ' .drug_form'));
      return false;
    }.bind(this)
  });
};

Pharmacy.prototype.initGraphs = function() {
  var graphs = d3.selectAll('svg.smallSparkline')[0];
  for (var i = 0; i < graphs.length; i += 1) {
    var graph = graphs[i];
    var data = JSON.parse(graph.dataset['points']).map(function(point) {
      return [new Date(point[0] * 1000), point[1]];
    });
    window.data = data;

    var dates = data.map(function(el) { return el[0]; });
    var x_scale = d3.time.scale()
      .domain([d3.min(dates), d3.max(dates)])
      .range([0, 150]);

    var amounts = data.map(function(el) { return el[1]; })
    var y_scale = d3.scale.linear()
      .domain([d3.min(amounts), d3.max(amounts)])
      .range([14, 2]);

    var line = d3.svg.line()
      .x(function(d) { return x_scale(d[0]); })
      .y(function(d) { return y_scale(d[1]); });

    d3.select(graph)
      .append('path')
      .classed('line', true)
      .datum(data)
      .attr('d', line);
  }
};

Pharmacy.prototype.alertDrug = function(drugID) {
  var drug = $('#drug' + drugID + ' .info');
  drug.addClass('alert');
  drug.removeClass('no_alert');
};

Pharmacy.prototype.unAlertDrug = function(drugID) {
  var drug = $('#drug' + drugID + ' .info');
  drug.addClass('no_alert');
  drug.removeClass('alert');
};

$(document).ready(function() {
  pharmacy = new Pharmacy();
  pharmacy.init();
});

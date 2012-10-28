var Pharmacy = function() { };

Pharmacy.prototype = new Raxa();

Pharmacy.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initDOMListeners();
  this.initSparklines();
  this.initTimeGraphs();
};

Pharmacy.prototype.initDOMListeners = function() {
  var pharmacy = this;
  $('.details_container').hide();
  $('.info').bind('click', function() {
    $(this).next().find('.details_container').slideToggle();
  });

  $(document).on('submit', '.drug_form', function(event) {
    event.preventDefault();
    $(this).ajaxSubmit({
      success: function(data) {
        pharmacy.displayNotice(data.notice);
        var drugID = '#drug' + data.id;
        $(drugID).replaceWith(data.data);
      }
    });
  });
};

Pharmacy.prototype.initSparklines = function() {
  var graphs = d3.selectAll('svg.smallSparkline')[0];
  for (var i = 0; i < graphs.length; i += 1) {
    var graph = graphs[i];
    var data = JSON.parse(graph.dataset['points']).map(function(point) {
      return [new Date(point[0] * 1000), point[1]];
    });

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

Pharmacy.prototype.initTimeGraphs = function() {
  var pharmacy = this;
  $('.drug').each(function() {
    pharmacy.drawDrugTimeGraph(this.dataset['drug_id'],
                               604800 /* 1 week */,
                               86400 /* 1 day */);
  })
};

Pharmacy.prototype.fetchDrugTimeGraph = function(drugID,
                                                how_long_ago,
                                                group_by_period,
                                                callback) {
  var param_string = $.param({
    'time_period': how_long_ago,
    'group_by_period': group_by_period
  });
  d3.json('/pharmacy/drugs/' + drugID + '/time_graph?' + param_string,
          callback);
};

Pharmacy.prototype.drawDrugTimeGraph = function(drugID, how_long_ago, group_by_period) {
  var time_graph = d3.select('#bigTimeGraph-' + drugID);
  if (time_graph.classed('hidden')) {
    this.fetchDrugTimeGraph(drugID, how_long_ago, group_by_period, function(response) {
      if (!response['data']) {
        pharmacy.displayNoTimeGraphHistoryNotice(drugID);
        return;
      }

      d3.select('#drug' + drugID + ' .bigTimeGraph')
        .classed('loading', false);
      time_graph.classed('hidden', false);

      var margin = {top: 10, bottom: 20, left: 50, right: 10};
      var height = 230 - margin.top - margin.bottom;
      var width = 480 - margin.left - margin.right;

      var dates = response['data'].map(function(el) { return new Date(el[0] * 1000); });
      var quantities = response['data'].map(function(el) { return el[1]; });

      var x = d3.time.scale()
        .domain([d3.min(dates), d3.max(dates)])
        .range([0, width]);

      var x_axis = d3.svg.axis()
        .scale(x)
        .orient("bottom")
        .ticks(8)
        .tickFormat(d3.time.format('%b %d'));

      var y = d3.scale.linear()
        .domain([d3.min(quantities), d3.max(quantities)])
        .range([height, 0]);
      var y_axis = d3.svg.axis()
        .scale(y)
        .orient('left')
        .ticks(5);

      var line = d3.svg.line()
        .x(function (d) { return x(d[0]); })
        .y(function (d) { return y(d[1]); });

      var data = d3.zip(dates, quantities);

      var drawing_area = time_graph.selectAll('g.drawing')
        .data([0])
        .enter()
        .append('g')
        .classed('drawing', true)
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

      drawing_area.selectAll('path')
        .data([data])
        .enter()
        .append('path')
        .classed('line', true)
        .attr('d', line);

      drawing_area.selectAll('circle')
        .data(data)
        .enter()
        .append('circle')
        .attr('cx', function (d) { return x(d[0]); })
        .attr('cy', function (d) { return y(d[1]); })
        .attr('r', '2px');

      time_graph.append('g')
        .attr('transform', 'translate(' + margin.left + ', ' + (height + margin.top) + ')')
        .attr('class', 'axis')
        .call(x_axis)

      time_graph.append('g')
        .attr('class', 'axis')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
        .call(y_axis)
    });
  }
};

Pharmacy.prototype.displayNoTimeGraphHistoryNotice = function(drugID) {
  var time_graph_div = $('#drug' + drugID + ' .bigTimeGraph');
  time_graph_div.find('svg').addClass('hidden');
  time_graph_div.find('.noHistory').removeClass('hidden');
  time_graph_div.removeClass('loading');
};

$(document).ready(function() {
  pharmacy = new Pharmacy();
  pharmacy.init();
});

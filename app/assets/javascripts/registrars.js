var Registrar = function() { };

Registrar.prototype = new Raxa();
Registrar.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initPerformanceHistory();
};

Registrar.prototype.initPerformanceHistory = function() {
  var graph = d3.select('#registration_history_graph');

  var margin = {top: 10, bottom: 20, left: 50, right: 10};
  var height = 230 - margin.top - margin.bottom;
  var width = 480 - margin.left - margin.right;

  var data = JSON.parse(graph[0][0].dataset['points']).map(function(point) {
    var date = new Date(point[0] * 1000);
    return [new Date(point[0] * 1000), point[1]];
  });

  var dates = data.map(function(el) { return el[0]; });
  var x = d3.time.scale()
    .domain([d3.min(dates), d3.max(dates)])
    .range([0, width]);

  var x_axis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .ticks(data.length)
    .tickFormat(d3.time.format("%d/%m"));

  var amounts = data.map(function(el) { return el[1]; });
  var y = d3.scale.linear()
    .domain([d3.min(amounts), d3.max(amounts)])
    .range([height, 0]);

  var y_axis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(5);

  var line = d3.svg.line()
    .x(function(d) { return x(d[0]); })
    .y(function(d) { return y(d[1]); });

  var data = d3.zip(dates, amounts);

  var drawing_area = graph.selectAll('g.drawing')
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

  drawing_area.append('g')
    .attr('transform', 'translate(' + margin.left + ', ' + (height + margin.top) + ')')
    .attr('class', 'axis')
    .call(x_axis)

  drawing_area.append('g')
    .attr('class', 'axis')
    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
    .call(y_axis)
};

$(document).ready(function() {
  registrar = new Registrar();
  registrar.init();
});

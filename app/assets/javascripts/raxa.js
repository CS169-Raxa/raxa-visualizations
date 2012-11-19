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

Raxa.prototype.drawTimeGraph = function(graph, data, params) {
  params = params || {};
  data = data.map(function(point) {
    return {
      date: new Date(point.date * 1000),
      count: point.count
    };
  });

  var margin = {
    top: params.top || 10,
    bottom: params.bottom || 20,
    left: params.left || 50,
    right: params.right || 10
  };
  var height = (params.height || 230) - margin.top - margin.bottom;
  var width = (params.width || 480) - margin.left - margin.right;

  var dates = data.map(function(el) { return el.date; });
  var quantities = data.map(function(el) { return el.count; });

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
    .x(function (d) { return x(d.date); })
    .y(function (d) { return y(d.count); });

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
    .attr('cx', function (d) { return x(d.date); })
    .attr('cy', function (d) { return y(d.count); })
    .attr('y', function(d) { return d.count; })
    .attr('r', '2px');

  graph.append('g')
    .attr('transform', 'translate(' + margin.left + ', ' + (height + margin.top) + ')')
    .attr('class', 'axis')
    .call(x_axis);

  graph.append('g')
    .attr('class', 'axis')
    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
    .call(y_axis);
};

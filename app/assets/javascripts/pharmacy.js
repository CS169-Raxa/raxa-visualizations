// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.details div').hide();
  $('.info').bind('click', function() {
      $(this).next().find('div').slideToggle();
  });
  $('.drug_form').submit(function() {
    $.ajax({
      type: 'PUT',
      url: '/pharmacy/drugs/' + $(this).data('id'),
      data: {
        user_rate: $(this).find('.override_field').val(),
        alert_level: $(this).find('.alert_field').val(),
      }
    });
    return false;
  });
});

$(function() {
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
});

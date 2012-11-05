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

  $(document).on('mouseover', '.bigTimeGraph circle', function() {
    d3.select(this).transition()
      .duration(500)
      .attr('r', '5px')
      .attr('opacity', .5);
  });

  $(document).on('mouseout', '.bigTimeGraph circle', function() {
    d3.select(this).transition()
      .duration(500)
      .attr('r', '2px')
      .attr('opacity', 1);
  });

  $('.bigTimeGraph circle').tipsy({
    live: true,
    offset: 10,
    gravity: 'w',
    html: false,
    trigger: 'hover',
    title: function() {
      return d3.select(this).attr('y');
    }
  });
};

Pharmacy.prototype.initSparklines = function() {
  var graphs = d3.selectAll('svg.smallSparkline')[0];
  for (var i = 0; i < graphs.length; i += 1) {
    var graph = graphs[i];
    var data = JSON.parse(graph.dataset['points']).map(function(point) {
      return {
        date: new Date(point.date * 1000),
        count: point.count
      };
    });

    var dates = data.map(function(el) { return el.date; });
    var x_scale = d3.time.scale()
      .domain([d3.min(dates), d3.max(dates)])
      .range([0, 150]);

    var amounts = data.map(function(el) { return el.count; })
    var y_scale = d3.scale.linear()
      .domain([d3.min(amounts), d3.max(amounts)])
      .range([14, 2]);

    var line = d3.svg.line()
      .x(function(d) { return x_scale(d.date); })
      .y(function(d) { return y_scale(d.count); });

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
      this.drawTimeGraph(time_graph, response.data);
    }.bind(this));
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

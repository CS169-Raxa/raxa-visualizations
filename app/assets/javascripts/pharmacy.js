var Pharmacy = function() { };

Pharmacy.prototype = new Raxa();

Pharmacy.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initDOMListeners();
  this.initSparklines();
  this.initTimeGraphs();
};

Pharmacy.prototype.getDrugNodeID = function(drugID) {
  return '#drug' + drugID;
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
        $(pharmacy.getDrugNodeID(data.id)).replaceWith(data.data);
        // Above expression returns replaced node, not new node
        $(pharmacy.getDrugNodeID(data.id)).trigger('reload-drug', data.id);
      }
    });
  });

  $('.bigTimeGraph').on('mouseover', 'circle', function() {
    d3.select(this).transition()
      .duration(500)
      .attr('r', '5px')
      .attr('opacity', .5);
  });

  $('.bigTimeGraph').on('mouseout', 'circle', function() {
    d3.select(this).transition()
      .duration(500)
      .attr('r', '2px')
      .attr('opacity', 1);
  });

  $('.bigTimeGraph circle').tipsy({
    fade: true,
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
  var pharmacy = this;
  var drawSparkline = function() {
    pharmacy.drawSparkline(this.dataset['drug_id']);
  };
  $('#drugs').on('reload-drug', '.drug', drawSparkline)
    .find('.drug')
    .trigger('reload-drug');
};

Pharmacy.prototype.drawSparkline = function(drugID) {
  var x_scale = d3.time.scale();
  var y_scale = d3.scale.linear();

  d3.select(this.getDrugNodeID(drugID) + ' svg.smallSparkline')
    .datum(function() {
      var data = JSON.parse(this.dataset['points']).map(function(point) {
        return {
          date: new Date(point.date * 1000),
          count: point.count
        };
      });
      var dates = data.map(function(el) { return el.date; });
      x_scale
        .domain([d3.min(dates), d3.max(dates)])
        .range([0, 150]);

      var amounts = data.map(function(el) { return el.count; })
      y_scale
        .domain([d3.min(amounts), d3.max(amounts)])
        .range([14, 2]);

      return data;
    })
    .append('path')
    .classed('line', true)
    .attr('d', d3.svg.line()
          .x(function(d) { return x_scale(d.date); })
          .y(function(d) { return y_scale(d.count); })
    );
};

Pharmacy.prototype.alertDrug = function(drugID) {
  var drug = $(this.getDrugNodeID(drugID) + ' .info');
  drug.addClass('alert');
  drug.removeClass('no_alert');
};

Pharmacy.prototype.unAlertDrug = function(drugID) {
  var drug = $(this.getDrugNodeID(drugID) + ' .info');
  drug.addClass('no_alert');
  drug.removeClass('alert');
};

Pharmacy.prototype.initTimeGraphs = function() {
  var pharmacy = this;
  var drawGraph = function() {
    pharmacy.drawDrugTimeGraph(this.dataset['drug_id']);
  };
  $('.drug').each(drawGraph);
  $('#drugs').on('reload-drug', '.drug', drawGraph);
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
  how_long_ago = how_long_ago || 604800 /* 1 week */;
  group_by_period = group_by_period || 86400 /* 1 day */;

  var pharmacy = this;
  var time_graph = d3.select('#bigTimeGraph-' + drugID);
  this.fetchDrugTimeGraph(drugID, how_long_ago, group_by_period, function(response) {
    if (!response['data']) {
      pharmacy.displayNoTimeGraphHistoryNotice(drugID);
      return;
    }

    d3.select(pharmacy.getDrugNodeID(drugID) + ' .bigTimeGraph')
      .classed('loading', false);
    time_graph.classed('hidden', false);

    this.drawTimeGraph(time_graph, response.data);
  }.bind(this));
};

Pharmacy.prototype.displayNoTimeGraphHistoryNotice = function(drugID) {
  var time_graph_div = $(this.getDrugNodeID(drugID) + ' .bigTimeGraph');
  time_graph_div.find('svg').addClass('hidden');
  time_graph_div.find('.noHistory').removeClass('hidden');
  time_graph_div.removeClass('loading');
};

$(document).ready(function() {
  pharmacy = new Pharmacy();
  pharmacy.init();
});

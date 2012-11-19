// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var Superuser = function() {};

Superuser.prototype = new Raxa();

Superuser.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initTimelines();
};

Superuser.prototype.initTimelines = function() {
  this.retrievePatientInfo(function(data) {
    this.drawTimelines(data);
  }.bind(this));
};

Superuser.prototype.drawTimelines = function(data) {
  var options = {
    stage_bar_area_width: 650,
    patient_height: 30,
    stage_bar_height: 20,
    patient_y_offset: 50,
    total_width: 950,
    future_area_width: 50
  };

  options.total_height = data.length * options.patient_height
    + 2 * options.patient_y_offset;

  var svg = d3.select('svg#patients-timelines')
    .attr('width', options.total_width)
    .attr('height', options.total_height);

  var time_scale = d3.time.scale()
    .domain(this.getTimeWindow())
    .range([options.total_width - options.stage_bar_area_width
            - options.future_area_width,
            options.total_width - options.future_area_width]);
  time_scale.tickFormat(d3.time.format('%I%p'));

  options.time_scale = function(millisecond_input) {
    return time_scale(new Date(millisecond_input));
  };
  options.time_scale.original = time_scale;

  var time_axis = d3.svg.axis()
    .scale(time_scale)
    .orient('top')
    .ticks(d3.time.hours, 1)
    .tickSubdivide(3) // every 15 minutes
    .tickSize(options.total_height - options.patient_y_offset,
              options.total_height - options.patient_y_offset,
              0);

  svg.append('g')
    .classed('time-axis', true)
    .attr('transform', 'translate(0,'
          + (options.total_height - options.patient_y_offset/4) + ')')
    .call(time_axis);

  var patients = svg.selectAll('g.patient')
    .data(data)
    .enter()
    .append('g')
    .classed('patient', true);

  patients.each(this.drawTimeline(svg, options));
};

Superuser.prototype.getTimeWindow = function() {
  var TIME_WINDOW = 43200; // 12 hours
  return [new Date((new Date()).getTime() - (TIME_WINDOW * 1000)), new Date()];
};

Superuser.prototype.time_filter_stages = function(stages, options) {
  var early_cutoff = options.time_scale.original.domain()[0];
  return stages.filter(function(stage) {
    return new Date(stage.end * 1000) > early_cutoff;
  });
};

Superuser.prototype.starts_before_graph = function(stage, options) {
  return new Date(stage.start * 1000) > options.time_scale.original.domain()[0]
};

Superuser.prototype.drawTimeline = function(svg, options) {
  var superuser = this;
  var stage_colour = d3.scale.category10();

  /* Expects `this` to be the <g> DOM node representing a patient */
  return function(patient, patient_index) {
    var g = d3.select(this);
    var y = patient_index * options.patient_height + options.patient_y_offset;

    var stages = g.selectAll('stages')
      .data(superuser.time_filter_stages(patient.stages, options))
      .enter()
      .append('rect')
      .classed('stage', true)
      .attr('x', function(stage) {
        return superuser.starts_before_graph(stage, options)
          ? options.time_scale(stage.start)
          : options.time_scale.original.range()[0];
      })
      .attr('y', y)
      .attr('width', function(stage) {
        return stage.end !== null && !superuser.starts_before_graph(stage, options)
          ? options.time_scale(stage.end) - options.time_scale(stage.start)
          : options.stage_bar_area_width - options.time_scale(stage.start)
            + options.total_width - options.stage_bar_area_width - options.future_area_width;
      })
      .attr('height', options.stage_bar_height)
      .attr('rx', 2)
      .attr('ry', 2)
      .attr('fill', function(d) { return stage_colour(d.name); });

    stages.each(function(stage, stage_index) {
      $(this).tipsy({
        live: true,
        gravity: 'sw',
        trigger: 'hover',
        title: function() {
          return d3.select(this).datum().name;
        }.bind(this)
      });
    });

    var separator_y = y + options.patient_height
      - (options.patient_height - options.stage_bar_height)/2;
    g.append('line')
      .classed('separator', true)
      .attr('x1', options.total_width - options.stage_bar_area_width
                  - options.future_area_width)
      .attr('y1', separator_y)
      .attr('x2', options.total_width - options.future_area_width)
      .attr('y2', separator_y);

    g.append('text')
      .classed('name', true)
      .text(patient.name)
      .attr('x', 30)
      .attr('y', y + options.stage_bar_height);

  };
};

Superuser.prototype.retrievePatientInfo = function(callback) {
  return callback([
    {
      name: 'France Toujours Attendant',
      stages: [
        {
          name: 'Registration',
          start: (new Date()).getTime() - 14400000, // 4 hours ago
          end: (new Date()).getTime() - 12600000 // 3.5 hours ago
        },
        {
          name: 'Waiting',
          start: (new Date()).getTime() - 12600000,
          end: null
        }
      ]
    },
    {
      name: 'François Heureuse Chen',
      stages: [
        {
          name: 'Registration',
          start: (new Date()).getTime() - 21600000, // 6 hours ago
          end: (new Date()).getTime() - 18000000 // 5 hours ago
        },
        {
          name: 'Waiting',
          start: (new Date()).getTime() - 18000000,
          end: (new Date()).getTime() - 14400000, // 4 hrs ago
        },
        {
          name: 'Screening',
          start: (new Date()).getTime() - 14400000, // 4 hours ago
          end: (new Date()).getTime() - 7200000 // 2 hours ago
        },
        {
          name: 'Waiting',
          start: (new Date()).getTime() - 7200000,
          end: null
        }
      ]
    },
    {
      name: 'François Heureuse Chen',
      stages: [
        {
          name: 'Registration',
          start: (new Date()).getTime() - 21600000, // 6 hours ago
          end: (new Date()).getTime() - 18000000 // 5 hours ago
        },
        {
          name: 'Waiting',
          start: (new Date()).getTime() - 18000000,
          end: (new Date()).getTime() - 14400000, // 4 hrs ago
        },
        {
          name: 'Screening',
          start: (new Date()).getTime() - 14400000, // 4 hours ago
          end: (new Date()).getTime() - 7200000 // 2 hours ago
        },
        {
          name: 'Waiting',
          start: (new Date()).getTime() - 7200000,
          end: null
        }
      ]
    },
    {
      name: 'François Heureuse Chen',
      stages: [
        {
          name: 'Registration',
          start: (new Date()).getTime() - 21600000, // 6 hours ago
          end: (new Date()).getTime() - 18000000 // 5 hours ago
        },
        {
          name: 'Waiting',
          start: (new Date()).getTime() - 18000000,
          end: (new Date()).getTime() - 14400000, // 4 hrs ago
        },
        {
          name: 'Screening',
          start: (new Date()).getTime() - 14400000, // 4 hours ago
          end: (new Date()).getTime() - 7200000 // 2 hours ago
        },
        {
          name: 'Waiting',
          start: (new Date()).getTime() - 7200000,
          end: null
        }
      ]
    }

  ]);
};

$(document).ready(function() {
  superuser = new Superuser();
  superuser.init();
});

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var Superuser = function() {};

Superuser.prototype = new Raxa();

Superuser.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initTimelines();
};

Superuser.prototype.initTimelines = function() {
  this.retrivePatientInfo(function(data) {
    this.drawTimelines(data);
  }.bind(this));
};

Superuser.prototype.drawTimelines = function(data) {
  var svg = d3.select('svg#patients-timelines');
  var options = {
    name_width: 100,
    stage_bar_area_width: 650,
    patient_height: 20,
    stage_bar_height: 20,
    patient_y_offset: 50
  };

  var patients = svg.selectAll('g')
    .data(data)
    .enter()
    .append('g')
    .classed('patient', true);

  var time_scale = d3.time.scale()
    .domain(this.getTimeWindow())
    .range([100, 750]);
  time_scale.tickFormat(d3.time.format('%I%p'));

  options.time_scale = function(millisecond_input) {
    return time_scale(new Date(millisecond_input));
  };

  var time_axis = d3.svg.axis()
    .scale(time_scale)
    .orient('top')
    .ticks(d3.time.hours, 1)
    .tickSubdivide(12) // every 5 minutes
    .tickSize(6, 3, 0);

  patients.each(this.drawTimeline(svg, options));
};

Superuser.prototype.getTimeWindow = function() {
  var TIME_WINDOW = 43200; // 12 hours
  return [new Date((new Date()).getTime() - (TIME_WINDOW * 1000)), new Date()];
}

Superuser.prototype.drawTimeline = function(svg, options) {
  var superuser = this;
  var stage_colour = d3.scale.category10();

  /* Expects `this` to be the <g> DOM node representing a patient */
  return function(patient, patient_index) {
    var g = d3.select(this);
    var y = patient_index * options.patient_height + options.patient_y_offset;

    g.append('text')
      .classed('name', true)
      .text(patient.name)
      .attr('x', 30)
      .attr('y', y);

    var stages = g.selectAll('stages')
      .data(patient.stages)
      .enter()
      .append('rect')
      .classed('stage', true)
      .attr('x', function(stage) {
        return options.time_scale(stage.start);
      })
      .attr('y', y)
      .attr('width', function(stage) {
        return stage.end !== null
          ? options.time_scale(stage.end) - options.time_scale(stage.start)
          : options.stage_bar_area_width - options.time_scale(stage.start)
            + options.name_width;
      })
      .attr('height', options.stage_bar_height)
      .attr('rx', 2)
      .attr('ry', 2)
      .attr('fill', function(d) { return stage_colour(d.name); });

    stages.each(function(stage, stage_index) {
      var stage_rect = d3.select(this);
      var stage_x = stage_rect.attr('x');
      var stage_y = stage_rect.attr('y');
      var stage_width = stage_rect.attr('width');

      if (stage_width > 30) {
        g.append('text')
          .classed('stage-label', true)
          .text(stage.name)
          .attr('x', parseInt(stage_x) + 10)
          .attr('y', parseInt(stage_y) + options.stage_bar_height * 0.9)
          .attr('width', stage_width - 10)
          .attr('height', options.stage_bar_height);
      }
    });
  };
};

Superuser.prototype.retrivePatientInfo = function(callback) {
  return callback([
    {
      name: 'patient 1',
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
      name: 'patient 2',
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

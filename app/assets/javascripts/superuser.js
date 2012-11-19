var Superuser = function() { };

Superuser.prototype = new Raxa();
Superuser.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initEncountersHistory();
};

Superuser.prototype.initEncountersHistory = function() {

  var w = 520,
      h = 300,
      m = {top: 10,
           right: 100,
           bottom: 20,
           left: 50 };

  var chart = d3.box()
              .width(w - m.right - m.left)
              .height(h - m.top- m.bottom);

  var max = -Infinity,
      min = Infinity;
  $.each(data.map (function(x)  { return x.data;}), function(i, d) {
    max = Math.max(d.max, max);
    min = Math.min(d.min, min);
  });

  var ys = d3.scale.linear()
    .domain([min, max])
    .range([chart.height(), 0]);

  chart.yscale(ys);

  var y_axis = d3.svg.axis()
    .scale(ys)
    .orient('left');

  var dates = data.map(function(x) { return x.date; });
  dates.sort(function(d1, d2) { return d1 - d2; })
  var xs = d3.time.scale()
    .domain([dates[0], dates[dates.length - 1]])
    .range([0,chart.width()]);

  chart.xscale(xs);

  var x_axis = d3.svg.axis()
    .scale(xs)
    .ticks(d3.time.days,1)
    .orient('bottom');

  var svg = d3.select("body").selectAll("svg")
    .data([data])
    .enter().append("svg")
      .attr("class", "box")
      .attr("width", w + m.right + m.left)
      .attr("height", h + m.top + m.bottom);

  svg.append("g")
    .attr("transform", "translate(" + m.right + "," + m.bottom + ")")
    .call(chart);

  svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(" + m.right / 2 + ", " + m.bottom + ")")
    .call(y_axis);

  svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(" + m.right + ", " + h + ")")
    .call(x_axis);

};

var a = {
min: 3,
first: 7, 
median: 10,
third: 13,
max: 15 
}


var b = {
min: 2,
first: 10,
median: 14,
third: 18,
max: 20 
}

var c = {
min: 3,
first: 7, 
median: 10,
third: 13,
max: 15 
}

var data = [
{date:new Date("November 13, 2012"),
data: a },
{date:new Date("November 14, 2012"),
data: b },
{date:new Date("November 15, 2012"),
data: c },
{date:new Date("November 16, 2012"),
data: a },
{date:new Date("November 17, 2012"),
data: b },
{date:new Date("November 18, 2012"),
data: b },
{date:new Date("November 19, 2012"),
data: c } ];

d3.box = function() {
  var width = 1,
      height = 1,
      value = Number,
      tickFormat = null,
      xscale = null,
      yscale = null,
      boxwidth = 0;

  function box(g) {
    g.each(function(d, i) {
      boxwidth = Math.min(30, width/d.length);
      var g = d3.select(this);
      var plots = g.selectAll("g")
        .data(d);
      plots.enter().append("g").call(one_box);
    });
  };

  function one_box(g) {
    g.each(function(d, i) {
      var g = d3.select(this);

      g.attr("transform", "translate(" + xscale(d.date) + ",0)");
      d = d.data;

      var center = g.selectAll("line.center")
        .data([[d.max, d.min]]);

      center.enter().insert("line", "rect")
        .attr("class", "center")
        .attr("x1", 0)
        .attr("y1", function(d) { return yscale(d[0]); })
        .attr("x2", 0)
        .attr("y2", function(d) { return yscale(d[1]); });

      var box = g.selectAll("rect.box")
        .data([[d.first, d.third]]);

      box.enter().append("rect")
        .attr("class", "box")
        .attr("x", -boxwidth / 2)
        .attr("y", function(d) { return yscale(d[1]); })
        .attr("width", boxwidth)
        .attr("height", function(d) { return yscale(d[0]) - yscale(d[1]); });

      var medianLine = g.selectAll("line.median")
        .data([d.median]);

      medianLine.enter().append("line")
        .attr("class", "median")
        .attr("x1", -boxwidth/2)
        .attr("y1", yscale)
        .attr("x2", boxwidth/2)
        .attr("y2", yscale);

      var whisker = g.selectAll("line.whisker")
        .data([d.min, d.max]);

      whisker.enter().append("line") 
        .attr("class", "whisker")
        .attr("x1", -boxwidth/2)
        .attr("y1", yscale)
        .attr("x2", boxwidth/2)
        .attr("y2", yscale);
    });
  };

  box.height = function(x) {
    if (!arguments.length) return height;
    height = x;
    return box;
  };

  box.width = function(x) {
    if (!arguments.length) return width;
    width = x;
    return box;
  };

  box.yscale = function(x) {
    if (!arguments.length) return yscale;
    yscale = x;
    return box;
  };

  box.xscale = function(x) {
    if (!arguments.length) return xscale;
    xscale = x;
    return box;
  };

  return box;
};

$(document).ready(function() {
  superuser = new Superuser();
  superuser.init();
});

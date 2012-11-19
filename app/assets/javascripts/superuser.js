var Superuser = function() { };

Superuser.prototype = new Raxa();
Superuser.prototype.init = function() {
  Raxa.prototype.init.call(this);
  this.initEncountersHistory();
};

Superuser.prototype.initEncountersHistory = function() {

  var w = 120,
      h = 500,
      m = [10, 50, 20, 50];

  var chart = d3.box()
              .width(w - m[1] - m[3])
              .height(h - m[0] - m[2]);

  var max = -Infinity,
      min = Infinity;
  console.log(data);
  $.each(data, function(i, d) {
    max = d.max > max ? d.max : max;
    min = d.min < min ? d.min : min;
  });
  console.log(min);
  console.log(max);

  var ys = d3.scale.linear()
    .domain([min, max])
    .range([chart.height(), 0]);

  chart.yscale(ys);

  var y_axis = d3.svg.axis()
    .scale(ys)
    .orient('left');

  var svg = d3.select("body").selectAll("svg")
    .data(data)
    .enter().append("svg")
      .attr("class", "box")
      .attr("width", w + m[1] + m[3])
      .attr("height", h + m[0] + m[2])
    .append("g")
      .attr("transform", "translate(" + m[1] + "," + m[2] + ")")
      .call(y_axis)
      .call(chart);
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

var data = [a, b, c];

d3.box = function() {
  var width = 1,
      height = 1,
      value = Number,
      tickFormat = null,
      yscale = null;

  function box(g) {
    g.each(function(d, i) {
      var g = d3.select(this);

      var center = g.selectAll("line.center")
        .data([[d.max, d.min]]);

      center.enter().insert("line", "rect")
        .attr("class", "center")
        .attr("x1", width / 2)
        .attr("y1", function(d) { console.log(yscale(d[0])); return yscale(d[0]); })
        .attr("x2", width / 2)
        .attr("y2", function(d) { return yscale(d[1]); });

      var box = g.selectAll("rect.box")
        .data([[d.first, d.third]]);

      box.enter().append("rect")
        .attr("class", "box")
        .attr("x", 0)
        .attr("y", function(d) { return yscale(d[1]); })
        .attr("width", width)
        .attr("height", function(d) { return yscale(d[0]) - yscale(d[1]); });

      var medianLine = g.selectAll("line.median")
        .data([d.median]);

      medianLine.enter().append("line")
        .attr("class", "median")
        .attr("x1", 0)
        .attr("y1", yscale)
        .attr("x2", width)
        .attr("y2", yscale);

      var whisker = g.selectAll("line.whisker")
        .data([d.min, d.max]);

      whisker.enter().append("line") //???
        .attr("class", "whisker")
        .attr("x1", 0)
        .attr("y1", yscale)
        .attr("x2", width)
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

  return box;
};

$(document).ready(function() {
  superuser = new Superuser();
  superuser.init();
});

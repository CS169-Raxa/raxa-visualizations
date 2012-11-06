// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.form
//= require d3.v2.min

/**
 * Easily compose two functions:
 *
 *  var square = function(i) { return Math.pow(i, 2); };
 *  var double = function(i) { return i * 2; };
 *  var double_square = double.compose(square);
 *
 * Source: http://javascriptweblog.wordpress.com/2010/04/14/compose-functions-as-building-blocks/
 */
Function.prototype.compose  = function(argFunction) {
  var invokingFunction = this;
  return function() {
    return invokingFunction.call(this, argFunction.apply(this, arguments));
  }
}

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.details div').hide();
  $('.info').bind('click', function() {
      $(this).next().find('div').slideToggle();
  });
});

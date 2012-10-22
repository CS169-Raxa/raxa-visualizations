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

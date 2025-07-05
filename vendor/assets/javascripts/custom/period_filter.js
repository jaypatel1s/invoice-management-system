$(document).on('turbolinks:load', function(){
  hide_show_period($('.nav-item .nav-link.active'));
  $('.nav-item .nav-link').click(function(e){
    hide_show_period($(this));
  });
  $('#week-picker').on('change.datetimepicker', function (e) {
    value = $('.week-dates').val();
    if (value) {
      firstDate = moment(value, 'DD-MM-YYYY').day(0).format('DD-MM-YYYY');
      lastDate =  moment(value, 'DD-MM-YYYY').day(6).format('DD-MM-YYYY');
      $('.week-dates').val(firstDate + ' - ' + lastDate);
    }
  });
})

function hide_show_period(tab) {
  tab_id = $(tab).attr('id');
  if (tab_id) {
    if (tab_id.includes('day')) {
      $('#day-value').attr('disabled', false);
      $('.week-dates').attr('disabled', true);
      $('#monthpicker').attr('disabled', true);
      $('.start_date').attr('disabled', true);
      $('.end_date').attr('disabled', true);
    }
    else if (tab_id.includes('week')) {
      $('#day-value').attr('disabled', true);
      $('.week-dates').attr('disabled', false);
      $('#monthpicker').attr('disabled', true);
      $('.start_date').attr('disabled', true);
      $('.end_date').attr('disabled', true);
    }
    else if (tab_id.includes('month')) {
      $('#day-value').attr('disabled', true);
      $('.week-dates').attr('disabled', true);
      $('#monthpicker').attr('disabled', false);
      $('.start_date').attr('disabled', true);
      $('.end_date').attr('disabled', true);
    }
    else if (tab_id.includes('custom')) {
      $('#day-value').attr('disabled', true);
      $('.week-dates').attr('disabled', true);
      $('#monthpicker').attr('disabled', true);
      $('.start_date').attr('disabled', false);
      $('.end_date').attr('disabled', false);
    }
    else {
      $('#day-value').attr('disabled', true);
      $('.week-dates').attr('disabled', true);
      $('#monthpicker').attr('disabled', true);
      $('.start_date').attr('disabled', true);
      $('.end_date').attr('disabled', true);
    }
  }
}

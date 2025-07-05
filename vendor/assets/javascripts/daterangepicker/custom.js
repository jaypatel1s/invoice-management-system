function daterangepicker_format(start, end) {
  $('#daterangepicker-div span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
}

$(document).on('turbolinks:load', function(){
  $('#daterangepicker-div').daterangepicker({
    startDate: moment().subtract(29, 'days'),
    endDate: moment(),
    ranges: {
       'Today': [moment(), moment()],
       'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
       'This Week': [moment().startOf('week'), moment().endOf('week')],
       'Last week': [moment().subtract(6, 'days'), moment()],
       'Last 2 week': [moment().subtract(13, 'days'), moment()],
       'This Month': [moment().startOf('month'), moment().endOf('month')],
       'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
       'This Year': [moment().subtract('year').startOf('year'), moment().subtract('year').endOf('year')]
    }
  }, daterangepicker_format);

  $('#daterangepicker-div').on('apply.daterangepicker', function (e, picker) {
    $('#start_date').val(picker.startDate.format('MMMM D, YYYY'));
    $('#end_date').val(picker.endDate.format('MMMM D, YYYY'));
  });

  // Initiate Default value
  if ($('#start_date').val() != '' && $('#end_date').val() != '')
    daterangepicker_format(moment($('#start_date').val()), moment($('#end_date').val()));
});

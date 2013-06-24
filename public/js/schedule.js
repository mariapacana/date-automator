$(document).ready(function() {
  var datetimeTemplate = $('#datetime').html();
  var index = 0;

  var indexDate = function (num){
    return num.toString() + '[free_date]';
  };

  var indexTime = function (num){
    return num.toString() + '[start_time]';
  };

  var addDate = function () {
    $('#new_date_form').on('click', '.add_date', function(){
      $(this).remove();
      $('#datetime').append(datetimeTemplate);
      index++;
      $('#datetime input').eq(-1).attr('name', indexTime(index));
      $('#datetime input').eq(-2).attr('name', indexDate(index));
    });
  };

  var submitDates = function () {
    $('#schedule_submit').on('click', function(e){
      e.preventDefault();
      data = $('#new_date_form').serialize();
      $.ajax({
        url: "/schedule",
        method: "POST",
        data: data
      }).done(function(response){
        $('#current_date_div table').append(response);
      });
    });
  };

  addDate();
  submitDates();
});


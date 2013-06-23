$(document).ready(function() {
  var datetimeTemplate = $('#datetime').html();

  var addDate = function () {
    $('#new_date_form').on('click', '.add_date', function(){
      $(this).remove();
      $('#datetime').append(datetimeTemplate);
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
      });
    });
  };


  addDate();
  submitDates();
});


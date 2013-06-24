$(document).ready(function() {
  var datetimeTemplate = $('#datetime').html();
  var index = 0;

  var indexedField = function (num, type){
    return num.toString() + '[' + type + ']';
  };

  var addIndexToFreeTime = function() {
    index++;
    console.log(index);
    $('#datetime input').eq(-1).attr('name', indexedField(index, 'free_date'));
    $('#datetime input').eq(-2).attr('name', indexedField(index, 'start_time'));
  };

  var addDate = function () {
    $('#new_date_form').on('click', '.add_date', function(){
      $(this).remove();
      $('#datetime').append(datetimeTemplate);
      addIndexToFreeTime();
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
        $('#all_free_dates').replaceWith(response);
        $('#new_date_form').trigger('reset');
      });
    });
  };

  addDate();
  submitDates();
});


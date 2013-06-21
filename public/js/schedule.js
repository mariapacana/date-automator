$(document).ready(function() {
  var datetimeTemplate = $('#datetime_template').html();

  // USE EVENT DELEGATION HERE
  var addDate = function(dateButton){
    dateButton.remove();
    datetime = $(datetimeTemplate);

    $('#datetime').append(datetimeTemplate);
  };

  var bindDate = function () {
    $('.datetime').on('click', function(){
      addDate($(this));
    });
    // bindDate();
  };

});


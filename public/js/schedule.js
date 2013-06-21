$(document).ready(function() {
  var datetimeTemplate = $('#datetime').html();
 
 var addDate = function(dateButton){
    dateButton.remove();
    $('#datetime').append(datetimeTemplate);
  };

  var bindDate = function () {
    $('#datetime').on('click', '.add_date', function(){
      console.log('hey');
      console.log($(this));
      addDate($(this));
    });
  };

  bindDate();
});


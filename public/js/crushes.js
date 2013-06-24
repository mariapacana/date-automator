$(document).ready(function() {
  var crushTemplate = $('#crush').html();
  var index = 0;

  var indexedField = function (num, type){
    return num.toString() + '[' + type + ']';
  };

  var addIndexToCrush = function() {
      index++;
      $('#crush input').eq(-1).attr('name', indexedField(index, 'phone'));
      $('#crush input').eq(-2).attr('name', indexedField(index, 'last_name'));
      $('#crush input').eq(-3).attr('name', indexedField(index, 'first_name'));
  };

  var addCrush = function () {
    $('#new_crush_form').on('click', '.add_crush', function(){
      $(this).remove();
      $('#crush').append(crushTemplate);
      addIndexToCrush();
    });
  };


  var addDate = function () {
    $('#new_date_form').on('click', '.add_date', function(){
      $(this).remove();
      $('#datetime').append(datetimeTemplate);
      addIndexToFreeTime();
    });
  };

  var submitCrushes = function () {
    $('#crushes_submit').on('click', function(e){
      e.preventDefault();
      data = $('#new_crush_form').serialize();
      $.ajax({
        url: "/crushes",
        method: "POST",
        data: data
      }).done(function(response){
        $('#all_crushes').replaceWith(response);
        $('#new_crush_form').trigger('reset');
      });
    });
  };

  addCrush();
  submitCrushes();
});


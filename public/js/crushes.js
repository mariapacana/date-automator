$(document).ready(function() {
  var crushTemplate = $('#crush').html();
 
 var addCrush = function(crushButton){
    crushButton.remove();
    $('#crush').append(crushTemplate);
  };

  var bindCrush = function () {
    $('#crush').on('click', '.add_crush', function(){
      addCrush($(this));
    });
  };

  bindCrush();
});


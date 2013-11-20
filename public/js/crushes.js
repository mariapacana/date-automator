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

  var addGoogleCrushInfo = function(firstName, lastName, phone) {
    $('#crush input').eq(-3).val(firstName);
    $('#crush input').eq(-2).val(lastName);
    $('#crush input').eq(-1).val(phone);
  };

  var addGoogleCrush = function () {
    $('#contacts').on('click', '.contact', function () { 
      var firstName = $(this).find(".contact-first-name").html();
      var lastName = $(this).find(".contact-last-name").html();
      var phone = $(this).find(".contact-phone").html();
      $('#crush').append(crushTemplate);
      addIndexToCrush();
      addGoogleCrushInfo(firstName, lastName, phone);
      $(this).css('border-color', '#FF1493');
    });
  };


  var addCrush = function () {
    $('#new_crush_form').on('click', '.add_crush', function(){
      $(this).remove();
      $('#crush').append(crushTemplate);
      addIndexToCrush();
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
  addGoogleCrush();
  submitCrushes();
});


$(document).ready(function() {

  var index = 0;

  var crushTemplate = $('#new_crush').html()+
                      ("<button id='remove_crush'>Remove Crush</button><br>");

  var indexedField = function (num, type){
    return num.toString() + '[' + type + ']';
  };

  var addIndexToCrush = function() {
    index++;
    $('#crush input').eq(-3).attr('name', indexedField(index, 'first_name'));
    $('#crush input').eq(-2).attr('name', indexedField(index, 'last_name'));
    $('#crush input').eq(-1).attr('name', indexedField(index, 'phone'));
  };

  var addCrushInfo = function(firstName, lastName, phone) {
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
      addCrushInfo(firstName, lastName, phone);
      $(this).css('border-color', '#FF1493');
    });
  };

  var clearInputCrush = function () {
    var firstName = $("#new_crush input").eq(0).val("");
    var lastName = $("#new_crush input").eq(1).val("");
    var phone = $("#new_crush input").eq(2).val("");
  };

  var addCrush = function () {
    $('#add_crush').on('click', function() {

      var firstName = $("#new_crush input").eq(0).val();
      var lastName = $("#new_crush input").eq(1).val();
      var phone = $("#new_crush input").eq(2).val();

      $('#crush').append(crushTemplate);
      addIndexToCrush();
      addCrushInfo(firstName, lastName, phone);
      clearInputCrush();
    });
  };

  // var submitCrushes = function () {
  //   $('#crushes_submit').on('click', function(e){
  //     e.preventDefault();
  //     data = $('#new_crush_form').serialize();
  //     $.ajax({
  //       url: "/crushes",
  //       method: "POST",
  //       data: data
  //     }).done(function(response){
  //       $('#all_crushes').replaceWith(response);
  //       $('#new_crush_form').trigger('reset');
  //     });
  //   });
  // };

  addCrush();
  addGoogleCrush();
  // submitCrushes();
});


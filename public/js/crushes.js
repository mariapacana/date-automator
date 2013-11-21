$(document).ready(function() {

  var index = 0;

  var crushTemplate ="<div class='crush'>"+
                      $('#new_crush').html() + "</div>";

  var indexedField = function (num, type){
    return num.toString() + '[' + type + ']';
  };

  var addIndexToCrush = function() {
    index++;
    $('#crush input').eq(-3).attr('name', indexedField(index, 'first_name'));
    $('#crush input').eq(-2).attr('name', indexedField(index, 'last_name'));
    $('#crush input').eq(-1).attr('name', indexedField(index, 'phone'));
  };

  var addCrushInfo = function(firstName, lastName, phone, id) {
    var crush = $('.crush').last();
    crush.find(':nth-child(1)').val(firstName);
    crush.find(':nth-child(2)').val(lastName);
    crush.find(':nth-child(3)').val(phone);
    crush.find(':nth-child(4)').text("Remove");
    crush.find(':nth-child(4)').attr("class", "remove_crush");
    if (id !== null) { crush.attr('id', id) };
  };

  var addGoogleCrush = function () {
    $('#contacts').on('click', '.contact', function () { 
      var firstName = $(this).find(".contact-first-name").html();
      var lastName = $(this).find(".contact-last-name").html();
      var phone = $(this).find(".contact-phone").html();
      var id = $(this).attr("id");
      $('#crush').append(crushTemplate);
      addIndexToCrush();
      addCrushInfo(firstName, lastName, phone, id);
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
      addCrushInfo(firstName, lastName, phone, null);
      clearInputCrush();
    });
  };

  var removeCrushes = function () {
    $('#crush').on('click', '.remove_crush', function() {
      $(this).parent().remove();
      $(this).closest('br').remove();
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
  removeCrushes();
  submitCrushes();
});


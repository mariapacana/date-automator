$(document).ready(function() {

  $("#import").click( function(event) {
    importContacts();
  });

  var importContacts = function() {
    $.ajax({
      url: "/all_contacts",
      type: "GET",
      success: function(response) {
        var allContacts = $.parseJSON(response);
        processContacts(allContacts);
      }
    });
  }

  var processContacts = function(contacts) {
    $.each(contacts, function(index, contact) {
      getContactPhoto(contact.photo);
    });
  }

  var getContactPhoto = function(photoUrl) {
    $.ajax({
      url: photoUrl,
      type: "GET",
      success: function(response) {
        console.log(response);
        // $("#contactphun").append(response);
      }
    });
  }
});
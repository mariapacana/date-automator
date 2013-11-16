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
    // var id = {};
    // id['contact_id'] = contacts[0].id;
    // getContactPhoto(id);
    $.each(contacts, function(index, contact) {
      var id = {};
      id['contact_id'] = contact.id;
      getContactPhoto(id);
    });
  }

  var getContactPhoto = function(id) {
    $.ajax({
      url: "/get_photo",
      type: "GET",
      data: id,
      success: function(response) {
        console.log(response);
        if (response !== "404 Not Found") {
          var image = document.createElement('img');
          image.src = 'data:image/jpg;base64,'+ response;
          $("#contactphun").append(image);
        }
      }
    });
  }
});
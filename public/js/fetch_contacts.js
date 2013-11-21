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
      var contactData = {};
      contactData['id'] = contact.id;
      contactData['first_name'] = contact.first_name;
      contactData['last_name'] = contact.last_name;
      contactData['phone'] = contact.phone;
      getContactPhoto(contactData);
    });
  }

  var getContactPhoto = function(contact) {
    $.ajax({
      url: "/get_photo",
      type: "GET",
      data: contact,
      success: function(response) {
        console.log(response);
        if (response !== "Error") {
          $("#contacts").append(response);
        }
      }
    });
  }
});
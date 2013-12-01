$(document).ready(function() {

  $("#opt_out_google").click( function(event) {
    optOutGoogle();
    console.log("ya");
  });

  var optOutGoogle = function() {
    $.ajax({
      url: "/opt_out_google",
      type: "GET"
    }).done(function(response){
      console.log("removing?");
      console.log($(this));
      $("#g_oauth").remove();
    });;
  }

});


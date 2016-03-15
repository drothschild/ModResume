$(document).ready(function() {
  console.log("Page Ready");
  bindListeners();
});

var bindListeners = function() {
  $('#new-resume-button').on("click", newResume);
}

var newResume = function(e) {
  e.preventDefault();
  var userId = $('.navbar-text').attr("user_id");
  $.ajax({
    url: "/users/" + userId + "/resumes/new",
    method: "GET"
  })
  .done(function(response) {
    $('div#new-resume-form').append(response);
    $('#new-resume-button').fadeOut(250, function(){
      //
    });
    $('#dashboard-instructions').fadeOut(250, function(){
      $('div#new-resume-form').fadeIn(250);
    })
  })
  .fail(function(response) {
  })
}

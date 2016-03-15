$(document).ready(function() {
  // console.log("Page Ready");
  bindListeners();
});

var bindListeners = function() {
  $('#new-resume-button').on("click", newResume);

}



var newResume = function(e) {
  e.preventDefault();
  var userId = $('.navbar-text').attr("user_id");
  console.log("Add New Resume Button Clicked");
  console.log(this);
  $.ajax({
    url: "/users/" + userId + "/resumes/new",
    method: "GET"
  })
  .done(function(response) {
    console.log("Successful GET");
    console.log("****************");
    console.log(response);
    console.log("****************");
    $('div#new-resume-form').append(response);
    $('#new-resume-button').hide();
  })
  .fail(function(response) {
    console.log("Failed GET");
    console.log(response);
  })
}

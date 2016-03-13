$(document).ready(function() {
  console.log("Page Ready");

  bindListeners();
});

var bindListeners = function() {
  $('.asset-resume').on("click", addAsset);
  $('#new-resume-button').on("click", newResume);
}

var addAsset = function(e) {
  e.preventDefault();
  console.log("Add Asset Button Clicked");
  console.log(this);
  var resumeId = $('#resumeID')[0].innerText;
  console.log(resumeId);
  var data = {
    current_user_id: $(this).attr("current_user_id"),
    data_asset_id: $(this).attr("data-asset-id"),
    data_asset_type: $(this).attr("data-asset-type"),
  };
  console.log(data);
  $.ajax({
    url: "/users/" + data.current_user_id + "/resumes/" + resumeId,
    method: "PATCH",
    data: data
  })
  .done(function(response) {
    console.log("Successful Patch");
  })
  .fail(function(response) {
    console.log("Failed Patch");
    console.log(response);
  })
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
$(document).ready(function() {
  console.log("Page Ready");

  bindListeners();
});

var bindListeners = function() {
  $('.asset-resume').on("click", addAsset);
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
    data_asset_type: $(this).attr("data-asset-type")
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
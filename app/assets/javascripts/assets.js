$(document).ready(function() {
  console.log("Page Ready");

  bindAssetListeners();
});

var bindAssetListeners = function() {
  $('.tag-button').on("click", toggleTag);
}

var toggleTag = function(e) {
  e.preventDefault();
  console.log("Tag Button Clicked");
  console.log(this);
  var tagID = $(this).attr("tag_id");
  console.log(tagID);
  $(this).toggleClass("tag-button-selected")
}
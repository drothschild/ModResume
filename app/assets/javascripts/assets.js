$(document).ready(function() {
  console.log("Page Ready");

  bindAssetListeners();
});

var bindAssetListeners = function() {
  $('.tag-button').on("click", toggleTag);
  $('.asset-resume').on("click", addAsset);
}

var toggleTag = function(e) {
  e.preventDefault();
  console.log("Tag Button Clicked");
  // console.log(this);
  var tagID = $(this).attr("tag_id");
  // console.log(tagID);
  $(this).toggleClass("tag-button-selected");
  var visible = $(this).hasClass("tag-button-selected");
  toggleAssets(tagID, visible);
}

var toggleAssets = function(tagID, visible) {
  console.log(tagID);
  var assetDivs = $(".asset-container");
  // console.log("Asset Divs:");
  // console.log(assetDivs);
  for (var i = 0; i < assetDivs.length; i++) {
    // console.log($(assetDivs[i]).attr("asset_id"));
    // console.log($(assetDivs[i]).attr("tags"));
    if ($(assetDivs[i]).attr("tags").includes("|" + tagID + "|") == true) {
      if (visible === true) {
        $(assetDivs[i]).show();
      }
      else {
        $(assetDivs[i]).hide();
      }
    }
  }
}

var addAsset = function(e) {
  e.preventDefault();
  console.log("Add Asset Button Clicked");
  console.log(this);
  var button = $(this);
  var resumeId = $('#resumeID').attr("resume_id");
  console.log(resumeId);
  var data = {
    current_user_id: $(this).attr("current_user_id"),
    data_asset_id: $(this).attr("data-asset-id"),
    data_asset_type: $(this).attr("data-asset-type"),
  };
  console.log(data);
  $.ajax({
    accepts: "application/json",
    url: "/users/" + data.current_user_id + "/resumes/" + resumeId,
    method: "PATCH",
    data: data
  })
  .done(function(response) {
    console.log("Successful Patch");
    console.log(response);
    if (response["update_status"] === "added") {
      button.children('span').removeClass("glyphicon-plus");
      button.children('span').addClass("glyphicon-minus");
      button.prop("title","Remove from Resume");
    }
    else {
      button.children('span').removeClass("glyphicon-minus");
      button.children('span').addClass("glyphicon-plus");
      button.prop("title","Add to Resume");
    }
  })
  .fail(function(response) {
    console.log("Failed Patch");
    console.log(response);
  })
}
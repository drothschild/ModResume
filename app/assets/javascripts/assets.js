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
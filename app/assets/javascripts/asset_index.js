var bindAssetListeners = function() {
  $(document).on("click", '.tag-button', toggleTag );
  $(document).on("click", '.asset-resume', addAsset );
}

var bindAssetDescriptionListeners = function() {
  $(document).on("click", '.asset-check-box', assetDescriptionCheckbox);
}

var toggleTag = function(e) {
  e.preventDefault();
  var tagID = $(this).attr("tag_id");
  $(this).toggleClass("button-selected");
  var visible = $(this).hasClass("button-selected");
  toggleAssets(tagID, visible);
}

var toggleAssets = function(tagID, visible) {
  var assetDivs = $(".asset-container");
  for (var i = 0; i < assetDivs.length; i++) {
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

var addAsset = function(e, buttonPassed) {
  var button
  if (buttonPassed) {
    button = buttonPassed;
  }
  else
  {
    e.preventDefault();
    button = $(this);
  }
  button.blur();
  var resumeId = $('#resumeID').attr("resume_id");
  var dataAssetId = button.attr("data-asset-id");
  var dataAssetType = button.attr("data-asset-type");
  var checkboxes = $("." + dataAssetType + "-" + dataAssetId + "-descriptions");
  var selectedDescriptions = [];
  for (var i = 0; i < checkboxes.length; i++) {
    if ($(checkboxes[i]).is(':checked')) {
      selectedDescriptions.push(checkboxes[i].value);
    }
  }
  var data = {
    current_user_id: button.attr("current_user_id"),
    data_asset_id: dataAssetId,
    data_asset_type: dataAssetType,
    selected_descriptions: selectedDescriptions
  };
  $.ajax({
    accepts: "application/json",
    url: "/users/" + data.current_user_id + "/resumes/" + resumeId,
    method: "PATCH",
    data: data
  })
  .done(function(response) {
    if (response["update_status"] === "added") {
      button.removeClass("button-plus");
      button.addClass("button-minus");
      button.children('span').removeClass("glyphicon-plus");
      button.children('span').addClass("glyphicon-minus");
      button.prop("title","Remove from Resume");
      button.css("background-color", "#6E85A1");
    }
    else {
      button.removeClass("button-minus");
      button.addClass("button-plus");
      button.children('span').removeClass("glyphicon-minus");
      button.children('span').addClass("glyphicon-plus");
      button.prop("title","Add to Resume");
      button.css("background-color", "");
    }
  })
  .fail(function(response) {
    console.log("Failed Patch");
    console.log(response);
  })
}

var assetDescriptionCheckbox = function(e) {
  console.log("Asset Description Clicked");
  var parentDiv = $(this).parents("div#" + $(this).attr("parent_class"));
  var button = $("#" + parentDiv.attr("id") + " button.asset-resume");
  if ($("#" + parentDiv.attr("id") + " button.asset-resume span").hasClass("glyphicon-minus")) {
    addAsset(e, button);
  }
}

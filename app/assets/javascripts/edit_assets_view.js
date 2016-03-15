$(document).ready(function() {
  bindEditListeners();

});

var bindEditListeners = function (){
  $('body').on("click", '.edit-popup', editPopup );
  $('body').on("click", '.delete-asset', deleteAsset);
  // $('body').on("submit", "form", editAsset )
}

var editPopup = function(event) {
  event.preventDefault();
  var assetType = event.currentTarget.dataset.assetType;
  var assetId = event.currentTarget.dataset.assetId;
  var uri = window.location.pathname.replace("/assets", "/" + assetType + "/" + assetId +"/edit");
  dialog = $("#edit-form").dialog({
    autoOpen: false,
    modal: true,
    width:  1000,
    height: 700,
    buttons: {"Update":function (){
      editAsset(assetType, assetId);
    }}
  });
  dialog.dialog("open");
  $.ajax({url: uri, method: "GET"}).done(function(response){
    $('#form-container-edit').html(response);
    tagNames = $('#tags-names').attr("data-tag-names").trim()
    $("#tags").val(tagNames)
    form = dialog.find("form").on("submit", function(event){
      event.preventDefault();
      editAsset(assetType,assetId);
          })

  });
   };

var editAsset = function(assetType, assetId) {
  var assetToUpdate = "#" + assetType + "_" + assetId;
  var uri = $('form').attr('action');
  var data = $('form').serialize();
  $.ajax({url: uri, method: "Put", data: data}).done(function(response) {
    dialog.dialog("close");
    $(assetToUpdate).html(response);
     editTags(assetType,assetId);
  }
    );

}
var editTags = function(assetType, assetId) {
  console.log("Hey");
  var tagObject = {taggable_type: capitalizeFirstLetter(assetType.slice(0, -1)), taggable_id: assetId};
  tagObject["tag_names"]=$('input#tags')[0].value;
  var data = {tagging: tagObject};
  var uri = window.location.pathname.replace("/assets", "");
  var uri = uri + "/taggings";
  console.log(uri);
  $.ajax({url: uri, method: "POST", data: data}).done(function(response){
    // console.log(response);
    getUserTags();
   });
};

var getUserTags = function() {
  var uri = window.location.pathname.replace("/assets", "/tags");
  $.ajax({url: uri, method:"GET"}).done(function(response){
    $("#tag-buttons").html(response);
  })
}


function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}


var deleteAsset = function(event) {
  event.preventDefault();
  var assetId = event.currentTarget.dataset.assetId;
  var assetType = event.currentTarget.dataset.assetType;
  var uri = window.location.pathname.replace("/assets", "/" +assetType + "/");

}

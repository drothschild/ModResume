$(document).ready(function() {
  bindEditListeners();

});

var bindEditListeners = function (){
  $('body').on("click", '.edit-popup', editPopup );
  $('body').on("click", '.delete-asset', deleteAsset);
}

var editPopup = function(event) {
  console.log($(this));
  event.preventDefault();
  var assetType = event.currentTarget.dataset.assetType;
  var assetId = event.currentTarget.dataset.assetId;
  var uri = window.location.pathname.replace("/assets", "/" + assetType + "/" + assetId +"/edit");
  dialog = $("#edit-form").dialog({
    autoOpen: false,
    modal: true,
    width:  1000,
    height: 700
  });
  dialog.dialog("open");
  $.ajax({url: uri, method: "GET"}).done(function(response){
    $('#form-container').html(response);
  });
  form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      var data = $('form').serialize();
      var tags = $('input#tags')[0].value;
    $.ajax({url: uri, method: "Put", data: data}).done(function(response){
    var tagObject = {taggable_type: assetType, taggable_id: assetId}
     tagObject["tag_names"]=tags
    var data = {tagging: tagObject}
    console.log(data)
    var uri = window.location.pathname.replace("/assets", "")
    console.log(uri)
    var uri = uri + "/taggings"
    debugger
    $.ajax({url: uri, method: "POST", data: data}).done(function(response){
    console.log(response)
     })
   });


} ) };

var deleteAsset = function(event) {
  event.preventDefault();
  var assetId = event.currentTarget.dataset.assetId;
  var assetType = event.currentTarget.dataset.assetType;

}

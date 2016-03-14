$(document).ready(function() {
  bindEditListeners();

});

var bindEditListeners = function (){
  $('body').on("click", '.edit-popup', EditPopup );
  $('body').on("click", '.delete-asset', DeleteAsset);
}

var EditPopup = function(event) {
  debugger;
  var dialog
  event.preventDefault();
  var assetId = event.currentTarget.dataset.assetId;
  var assetType = event.currentTarget.dataset.assetType;
  var uri = window.location.pathname.replace("/assets", "/" + assetType + "/" + assetId +"/edit");
  dialog = $("#edit-form").dialog({
    autoOpen: false,
    modal: true,
    width: 500,
    height: 700,
    buttons: {
        "Create an account": function(){

        },
        Cancel: function() {
          dialog.dialog( "close" );
        }
      },
  });


  dialog.dialog("open");
  $.ajax({url: uri, method: "GET"}).done(function(response){
    $('#form-container').html(response);
  })

}

var DeleteAsset = function(event) {
  event.preventDefault();
  var assetId = event.currentTarget.dataset.assetId;
  var assetType = event.currentTarget.dataset.assetType;

}

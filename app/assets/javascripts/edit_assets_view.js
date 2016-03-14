$(document).ready(function() {
  bindEditListeners();

});

var bindEditListeners = function (){
  $('body').on("click", '.edit-popup', editPopup );
  $('body').on("click", '.delete-asset', deleteAsset);
  // $('body').on("submit", "form", editAsset )
}

var editPopup = function(event) {
  console.log("Edit popup");
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
    $('#form-container').html(response);
    $('#form-container :submit').remove;
    form = dialog.find("form").on("submit", function(event){
      event.preventDefault();
      editAsset(assetType,assetId);
    })

  });
   };

var editAsset = function(assetType, assetId) {
  var assetToUpdate = "#" + assetType + "_" + assetId;
  console.log($(assetToUpdate));
  var uri = $('form').attr('action');
  var data = $('form').serialize();
  var tags = $('input#tags')[0].value;
  $.ajax({url: uri, method: "Put", data: data}).done(function(response) {
    console.log(response);
    dialog.dialog("close");
    $(assetToUpdate).html(response);
  }
    );
}


var deleteAsset = function(event) {
  event.preventDefault();
  var assetId = event.currentTarget.dataset.assetId;
  var assetType = event.currentTarget.dataset.assetType;
  $("#edit-form").dialog.close;
}

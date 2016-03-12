var allAssetsView = function (){}

allAssetsView.prototype.addTag = function(event){
  // console.log(event.currentTarget.dataset.assetId)
  var target = event.currentTarget
  var uri = window.location.pathname.replace("/assets", "")
  var uri = uri + "/taggings"
  var assetId = event.currentTarget.dataset.assetId
  var assetType = event.currentTarget.dataset.assetType
  var tagId = event.currentTarget.dataset.tagId
  $.ajax({url: uri, method: "POST", dataType: "json", data: {tagging: {taggable_id: assetId, taggable_type: assetType, tag_id: tagId }}}).done(function(response){
    $(target).context.checked=true;
  })
}


var assetsView = new allAssetsView();

$(document).ready(function(){
  $('.asset-tag').on("click", function(e){
    e.preventDefault();
    assetsView.addTag(e);
  })

})

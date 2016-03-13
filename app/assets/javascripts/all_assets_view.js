var allAssetsView = function (){}

allAssetsView.prototype.addAssetToResume = function(event){
  var target = event.currentTarget;
  var uri = window.location.pathname.replace("/assets", "")
  var uri = uri + "/resume_assets"
  var assetId = event.currentTarget.dataset.assetId
  var assetType = event.currentTarget.dataset.assetType
  $.ajax({url: uri, method: "POST", dataType: "json", data: {resume_asset:{buildable_id: assetId, buildable_type: assetType, resume_id: "54"}}}).done(function(response){
    console.log(response)
  })

}

allAssetsView.prototype.addTag = function(event){
  // console.log(event.currentTarget.dataset.assetId)
  var target = event.currentTarget
  var uri = window.location.pathname.replace("/assets", "")
  var uri = uri + "/taggings"
  var assetId = event.currentTarget.dataset.assetId
  var assetType = event.currentTarget.dataset.assetType
  var tagId = event.currentTarget.dataset.tagId
  $.ajax({url: uri, method: "POST", dataType: "json", data: {tagging: {taggable_id: assetId, taggable_type: assetType, tag_id: tagId }}}).done(function(response){
    // $(target).context.checked=true;
    $(target).toggle(this.checked);
  })
}

allAssetsView.prototype.removeTag = function(event){
  var taggingId = event.currentTarget.dataset.taggingId;
  var uri = window.location.pathname.replace("/assets", "")
  var uri = uri + "/taggings/" + taggingId
  $.ajax({url: uri, method: "DELETE", dataType: "json"}).done(function(response){
    console.log(response);
    // $(target).context.checked=false;
    $(target).toggle(this.checked);
  })

}


var assetsView = new allAssetsView();

$(document).ready(function(){
  $('.asset-tag').on("click", function(e){
    e.preventDefault();
    var target = e.currentTarget;
    console.log($(target).attr('checked'))
    if ($(target).attr('checked')){
      console.log("true")
      assetsView.removeTag(e);
    } else {
      console.log("false")
      assetsView.addTag(e);
    }
  })
  // $('.asset-resume').on("click", function(e){
  //   e.preventDefault();
  //   assetsView.addAssetToResume(e);
  //   console.log("click")
  // })

})

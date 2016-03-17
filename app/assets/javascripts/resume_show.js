var bindResumeShowListeners = function (){
  addSortable();
  $(document).on('click', '#save-resume-button', saveSortedResume);
  $(document).on('mouseup', '.asset-portlet', changeResumeSize)
  $(document).on('sortupdate', '#trashcan', deleteResumeAsset)
}

var addSortable = function(){
  $('.resume-content').sortable({
    connectWith: ".resume-content",
    handle: '.asset-portlet-header',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })
  $('.nested-sort').sortable({
    connectWith: ".nested-sort",
    handle: '.panel-heading',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })
  $( ".resume-template" ).resizable();
}

var deleteResumeAsset = function(e){
  var selectedElement = $(e.toElement).parent()
  var selectedAsset = $(e.toElement).parent().find('.panel').attr("id").split("_")
  var data = {data_asset_type: selectedAsset[0], data_asset_id: selectedAsset[1]}
  var uri = window.location.href
  $.ajax({url: uri, method: "PATCH", data})
    .done(function(response){
      $(selectedElement).remove();
    })
}

var saveSortedResume = function(e){
    e.preventDefault();
    var assetNodes = $('.panel.panel-default')
    for(var i = 0; i < assetNodes.length; i++){
      var assetTypeId = assetNodes[i].id.split('_');
      var parentLocationId = assetNodes[i].parentNode.parentNode.parentNode.parentNode.id.split('_');
      var resumeId = $(this).attr("resume_id")
      var data = { asset_type: assetTypeId[0], asset_id: assetTypeId[1], div_sort: parentLocationId[1], resume_id: resumeId};
      $.ajax({
        url: "/users/" + $(this).attr("current_user_id") + "/resume_assets/" + data.asset_id,
        method: "PATCH",
        data: data,
        dataType: 'json'
      })
      .done(function(response){
        console.log('success');
      })
      .fail(function(response){
        console.log('fail');
      });
    }
}
var changeResumeSize = function(){
  var sections = $('.resume-section')
  for (var i =0 ; i < sections.length; i++){
    var sectionCount = sections[i].children.length;
    if (sectionCount > 6){
      sections[i].style.height = '100%'
    } else {
      sections[i].style.height = ''
    }
  }
}

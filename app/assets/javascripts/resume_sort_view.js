$(document).ready(function() {
  $('.resume-content').sortable({
    connectWith: ".resume-content",
    handle: '.asset-portlet-header',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })
  // console.log("hello")

  $('.nested-sort').sortable({
    connectWith: ".nested-sort",
    handle: '.panel-heading',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })
  // console.log("hello")
});

$(document).ready(function() {
  $('#save-resume-button').on('click', function(e){
    e.preventDefault();
    console.log('Save resume button')
    // save to database as template
    var resumeTemplate = $('.resume-template')[0].innerHTML
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
      }).done(function(response){
        console.log('success');
      }).fail(function(response){
        console.log('fail');
      });

    }

  })

});


// $(function() {
//   $('.section').sortable({
//     connectWith: ".section",
//     handle: '.section-header',
//     placeholder: "section-placeholder ui-corner-all"

//   })
//   $('.asset-type').sortable();
//   console.log("hello")
// });

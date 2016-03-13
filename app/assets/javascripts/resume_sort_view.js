$(document).ready(function() {
  $('.resume-content').sortable({
    connectWith: ".resume-content",
    handle: '.asset-portlet-header',
    placeholder: "portlet-placeholder ui-corner-all"
  })
  // console.log("hello")

  $('.nested-sort').sortable({
    connectWith: ".nested-sort",
    handle: '.panel-heading',
    placeholder: "portlet-placeholder ui-corner-all"
  })
  // console.log("hello")



  $('#save-resume-button').on('click', function(e){
    e.preventDefault();
    console.log('Save resume button')
    // save to database as template
    var resumeTemplate = $('.resume-template')[0].innerHTML
    var assetNodes = $('.panel.panel-default')
    for(var i = 0; i < assetNodes.length; i++){

      var assetTypeId = assetNodes[i].id.split('_');
      var parentLocationId = assetNodes[i].parentNode.parentNode.parentNode.parentNode.id.split('_');

      // ['objective','112']
      // var assetTypeId = assetNodes[0].id.split('_')
      // ['divsection','2']
      // var parentLocationId = assetNodes[0].parentNode.parentNode.parentNode.parentNode.id.split('_')

      // debugger;
      var data = { asset_type: assetTypeId[0], asset_id: assetTypeId[1], div_sort: parentLocationId[1]};
      debugger;
      $.ajax({
        url: "/users/" + $(this).attr("current_user_id") + "/resume_assets/" + data.asset_id,
        method: "PATCH",
        data: data
      }).done(function(response){
        console.log('success');
      }).fail(function(response){
        console.log('fail');
      });

    }

  })


    // Iterate for each $('.panel.panel-default')
    // find the resume_asset field where buildable type equals asset type and id = id
    // assign the div_sort field to be the value of (parentNode.parentNode.parentNode.parentNode id div-section#)



    // the specific row the asset is placed in
    // $('#objective114')[0].parentNode.parentNode.parentNode.parentNode

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

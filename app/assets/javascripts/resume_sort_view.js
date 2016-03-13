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
    console.log($('.text-left.ui-sortable-handle'))
    console.log($('.asset type'))
    var resume_temp = $('.resume-template')[0].innerHTML
    debugger;

    })
    // $('.asset type')
    // $('.text-left.ui-sortable-handle')

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

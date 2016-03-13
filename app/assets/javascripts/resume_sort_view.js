$(function() {
  $('.resume-content').sortable({
    connectWith: ".resume-content",
    handle: '.asset-portlet-header',
    placeholder: "portlet-placeholder ui-corner-all"
  })
  console.log("hello")
});

$(function() {
  $('.nested-sort').sortable({
    connectWith: ".nested-sort",
    handle: '.panel-heading',
    placeholder: "portlet-placeholder ui-corner-all"
  })
  console.log("hello")
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

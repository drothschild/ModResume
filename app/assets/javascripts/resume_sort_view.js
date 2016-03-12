$(function() {
  $('.section').sortable({
    connectWith: ".section",
    placeholder: "section-placeholder ui-corner-all",
    cancel: '.section-header'

  })
  $('.asset-type').sortable();
  console.log("hello")
});

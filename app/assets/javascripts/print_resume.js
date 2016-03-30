var printResume = function(e) {
  e.preventDefault();
  var backup = $("body").html();
  var doc = $(".resume-template").html();
  $("body").css("margin", "10mm 10mm 10mm 10mm");
  $("body").html(doc);
  $("body").css("font-family", "Tahoma");
  $(".asset-portlet-header").addClass('h4');
  window.print();
  $("body").html(backup);
}

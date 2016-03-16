var printResume = function(e) {
  e.preventDefault();
  var backup = $("body").html();
  var doc = $(".resume-template").html();
  $("body").css("margin", "25mm 25mm 25mm 25mm");
  $("body").html(doc);
  window.print();
  $("body").html(backup);
}

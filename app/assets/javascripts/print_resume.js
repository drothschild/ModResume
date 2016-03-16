var printResume = function(e) {
  e.preventDefault();
  console.log ("Hahah");
  var backup = $("body").html();
  var doc = $(".resume-template").html();
  $("body").html(doc);
  window.print();
  $("body").html(backup);
}

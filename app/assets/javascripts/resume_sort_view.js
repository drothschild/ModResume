$(document).ready(function() {
  $('.resume-content').sortable({
    connectWith: ".resume-content",
    handle: '.asset-portlet-header',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })
  console.log("hello")
});

$(document).ready(function() {
  $('.nested-sort').sortable({
    connectWith: ".nested-sort",
    handle: '.panel-heading',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })
  console.log("hello")
});

// JSPDF JSPDF JSPDF JSPDF

function resumeFromHTML(){
  var pdf = new jsPDF('p', 'pt', 'letter');
  source = $('.resume-template')[0];

  specialElementHandlers = {
    '#skipme': function (element, renderer){
      return true
    }
  };

  margins = {
    top: 80,
    bottom: 60,
    left: 40,
    width: 522
  }

  pdf.fromHTML(
    source,
    margins.left,
    margins.top, {
      'width': margins.width,
      'elementHandlers': specialElementHandlers
  },

  function(dispose){
    pdf.save('Resume.pdf')
  }, margins );

}
// END JSPDF JSPDF JSPDF JSPDF

function printDiv(){
  console.log($('.resume-template').html());
  var printContents = $('.resume-template').html();
  var originalContents = document.body.innerHTML;

  document.body.innerHTML = printContents;
  window.print();
  document.body.innerHTML = originalContents;

}

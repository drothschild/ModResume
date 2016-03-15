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
    // debugger;
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

$(document).ready(function(){
 // $('.resume-section').click(function(e){
 //  var sectionCount = this.children.length
 //  debugger;
 //  if (sectionCount < 6){
 //    this.style.height = ''
 //  } else {
 //    this.style.height = '100%'
 //  }

 // })
})


$(function() {
    $( ".resume-template" ).resizable();
});

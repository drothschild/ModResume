$(document).ready(function(){
  $(".fine-tune-button").on("click", function(e){
    console.log("click")
    e.preventDefault();
    var data = $('.resume-template').html()
    var uri = $(this).attr("href")
    $.ajax({url: uri, method: "POST", data: {document_data: data}}).done(function(response){
      $("#resume-show-instructions").hide()
      $(".resume-fine-tune").show()
      $('.sortable-wrapper').html(response)
      setTimeout(function(){
        tinyMCE.activeEditor.setContent(data)
      }, 1000)
    })
  })


})

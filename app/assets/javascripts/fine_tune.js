$(document).ready(function(){
  $("#fine-tune-button").on("click", function(e){
    e.preventDefault();
    var data = $('.resume-template').html()
    var uri = $(this).attr("href")
    $.ajax({url: uri, method: "POST", data: {document_data: data}}).done(function(response){
      window.location.href = "localhost:3000/users/62/resumes/101/fine-tune"
      $('.sortable-wrapper').html(response)
      setTimeout(function(){
        tinyMCE.activeEditor.setContent(data)
      }, 1000)
    })
  })


})

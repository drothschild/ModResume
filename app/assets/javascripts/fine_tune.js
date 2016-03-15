$(document).ready(function(){
  $("#fine-tune-button").on("click", function(e){
    e.preventDefault();
    var data = $('.resume-template').html()
    console.log(data)
    var uri = $(this).attr("href")
    $.ajax({url: uri, method: "POST", data: {data:data}}).done(function(response){
      console.log(response)
    })
  })


})

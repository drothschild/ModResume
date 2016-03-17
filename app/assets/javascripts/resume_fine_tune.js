var bindFineTuneListeners = function(){
  $(document).on("click", ".fine-tune-button", loadFineTuneForm);
}

var loadFineTuneForm = function(e){
  e.preventDefault();
  tinyMCE.remove();
  var data = $('.resume-template').html();
  var uri = $(this).attr("href");

  $.ajax({url: uri, method: "POST", data: {document_data: data}})
    .done(function(response){
      var response = response
      $("#resume-show-instructions").fadeOut(250, function(){
        $(".resume-fine-tune").fadeIn(250, function(){
        });
      })
      $('.sortable-wrapper').fadeOut(250, function(){
        $('.sortable-wrapper').html(response);
        $('.sortable-wrapper').fadeIn(250, function(){
          setTimeout(function(){
            tinyMCE.activeEditor.setContent(data);
            tinyMCE.activeEditor.focus();
          }, 1000)
        })
      })
  })
}

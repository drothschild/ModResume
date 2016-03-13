var newAssetsView = function(){}

newAssetsView.prototype.loadForm = function(event){
  var uri = $(event.currentTarget).attr("href")
  $.ajax({url: uri, method: "GET"}).done(function(response){
    $('#form-container').html(response);
  })
}

newAssetsView.prototype.saveForm = function(event){
  console.log($(this))
  var data = $('form').serialize()
  var tags = $('input#tags')[0].value
  var uri = event.target.action
  $.ajax({url: uri, method: "POST", data: data}).done(function(response){
    console.log(response)
  })
}

var newAssets = new newAssetsView();
$(document).ready(function(){
  $('.asset-type-button').on("click", function(e){
    e.preventDefault();
    $(e.target.parentNode.children).removeClass("active");
    $(e.target).addClass("active");
    $('#form-container').html("");
    newAssets.loadForm(e);
  })
  $('#form-container').on("submit", 'form', function(e){
    e.preventDefault();
    //load a saved div
    newAssets.saveForm(e);
  })

})

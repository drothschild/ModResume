var newAssetsView = function(){}

newAssetsView.prototype.loadForm = function(event){
  var uri = $(event.currentTarget).attr("href")
  $.ajax({url: uri, method: "GET"}).done(function(response){
    $('#form-container').html(response);
  })

}

var newAssets = new newAssetsView();
$(document).ready(function(){
  console.log("new assets view here!")
  $('.asset-type-button').on("click", function(e){
    e.preventDefault();
    $(e.target.parentNode.children).removeClass("active");
    $(e.target).addClass("active");
    $('#form-container').html("");
    newAssets.loadForm(e);
  })

})

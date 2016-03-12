var newAssetsView = function(){}

newAssetsView.prototype.loadForm = function(event){
  // console.log($(event.currentTarget).attr("href"))
  var uri = $(event.currentTarget).attr("href")
  $.ajax({url: uri, method: "GET"}).done(function(response){
    console.log(response);
    $('#form-container').html(response);
    // $('#form-container').innerHTML=response.toString();
    console.log($('#form-container'))
  })

}

var newAssets = new newAssetsView();
$(document).ready(function(){
  console.log("new assets view here!")
  $('.asset-type-button').on("click", function(e){
    e.preventDefault();
    newAssets.loadForm(e);
  })

})

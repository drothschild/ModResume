$(document).on('page:change', function(event){
  bindResumeShowListeners();
})

$(document).ready(function(event){
  console.log("hello!");
  bindAssetListeners();
  bindAssetDescriptionListeners();
  bindDetailEvents();
  bindEditListeners();
  bindFineTuneListeners();
  bindResumeIndexListeners();
  openingAnimation();
  bindWebsiteListeners();
  bindNewAssetListeners();
})

var openingAnimation =   function(){
  setTimeout(function(){
    $("#long-paper").animate({
      height: 240
    }, 3000, "linear", function(){
      //
    })
  },2000)
  setTimeout(function(){
    $(".fa-frown-o").switchClass("fa-frown-o" ,"fa-smile-o");
    $('#animation-header').text('Into this!')
  }, 4000)
}

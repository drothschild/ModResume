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
      height: 1000
    }, 3000, "linear", function(){
      //
    })
  },2000)
}

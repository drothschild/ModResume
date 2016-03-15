var newAssetsView = function(){}

newAssetsView.prototype.addTags = function(){
  var availableTags = JSON.parse($("#tag-names").attr("data-tag-names")) || []
  function split( val ) {
      return val.split( /,\s*/ );
  }
  function extractLast( term ) {
      return split( term ).pop();
  }
  $("#tags")
  // don't navigate away from the field on tab when selecting an item
  .bind( "keydown" ,function( event ) {
    console.log("typed")
    if ( event.keyCode === $.ui.keyCode.TAB &&
        $( this ).autocomplete( "instance" ).menu.active ) {
                event.preventDefault();
    }
  })
  .autocomplete({
    minLength: 0,
    source: function( request, response ) {
      // delegate back to autocomplete, but extract the last term
      response( $.ui.autocomplete.filter(
        availableTags, extractLast( request.term ) ) );
    },
    focus: function() {
      // prevent value inserted on focus
      return false;
    },
    select: function( event, ui ) {
      var terms = split( this.value );
      // remove the current input
      terms.pop();
      // add the selected item
      terms.push( ui.item.value );
      // add placeholder to get the comma-and-space at the end
      terms.push( "" );
      this.value = terms.join( ", " );
      return false;
    }
  });
}

newAssetsView.prototype.loadForm = function(event){
  tinyMCE.remove();
  var uri = $(event.currentTarget).attr("href");
  $.ajax({url: uri, method: "GET", context: this}).done(function(response){
      $('#form-container').html(response);
    setTimeout(function(){
      $('#form-container').fadeIn(250, function(){
        //animation here
      })
      newAssets.addTags();
    },250)
  })
}

newAssetsView.prototype.saveForm = function(event){
  if  (event.currentTarget.className.search("edit")<0){
    var data = $('form').serialize()
    var tags = $('input#tags')[0].value
    var uri = event.target.action
    $.ajax({url: uri, method: "POST", data: data}).done(function(response){
      console.log(response)
      var response = response
      response["tag_names"]=tags
      var data = {tagging: response}
      console.log(response)
      var uri = window.location.pathname.replace("/assets/new", "")
      var uri = uri.replace("/assets", "")
      var uri = uri + "/taggings"
      $.ajax({url: uri, method: "POST", data: data}).done(function(response){
        console.log(response)
        $("#form-container").fadeOut(250, function(){
          $('#form-container').html("");
        })
        setTimeout(function(){
          $('.saved').fadeIn(250, function(){
            //animation complete
          })
        }, 300)
      })
    })
  }
}

var newAssets = new newAssetsView();
$(document).ready(function(){
  $('.asset-type-button').on("click", function(e){
    e.preventDefault();
    $(e.target.parentNode.children).removeClass("button-selected");
    $(e.target).addClass("button-selected");
    $(e.target).blur();
    $('.saved').fadeOut(250, function(){
            //animation complete
    })
    newAssets.loadForm(e);
  })
  $('#form-container').on("submit", 'form', function(e){
    e.preventDefault();
    //load a saved div
    newAssets.saveForm(e);
  })

})

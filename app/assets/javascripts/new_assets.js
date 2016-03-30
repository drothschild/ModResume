var newAssetsView = function(){}

newAssetsView.prototype.loadForm = function(event){
  var uri = $(event.currentTarget).attr("href");
  $.ajax({
    url: uri,
    method: "GET",
    context: this
  })
  .done(function(response){
    setTimeout(function(){
      tinyMCE.remove();
      $('#form-container').html(response);
      $('#form-container').fadeIn(250, function(){
        addTags();
      })
    }, 250)
  })
}

newAssetsView.prototype.saveForm = function(event){
  event.preventDefault();
  if  (event.currentTarget.className.search("edit") < 0 ){
    var data = $('form').serialize()
    var tags = $('input#tags')[0].value
    var uri = event.target.action
    $.ajax({
      url: uri,
      method: "POST",
      dataType: "json",
      data: data
    }).done(function(response){
        $("#form-container").fadeOut(250, function(){
          $('#form-container').html("");
        })
        setTimeout(function(){
          $('.saved').fadeIn(250, function(){});
        }, 300)
      }).error(jqXHR, textStatus, errorThrown){$(".alert").html(xhr.status)

    }
    }
}



newAssetsView.prototype.toggleActiveAsset = function(e){
    e.preventDefault();
    $(e.target.parentNode.children).removeClass("button-selected");
    $(e.target).addClass("button-selected");
    $(e.target).blur();
    $('#form-container').fadeOut(250, function(){});
    $('.saved').fadeOut(250, function(){});
    newAssets.loadForm(e);
}

var addTags = function(){
  var availableTags = JSON.parse($("#all-tags-names").attr("data-tag-names")) || []
  function split( val ) {
      return val.split( /,\s*/ );
  }
  function extractLast( term ) {
      return split( term ).pop();
  }
  $("#tags")
  // don't navigate away from the field on tab when selecting an item
  .bind( "keydown" ,function( event ) {
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

newAssetsView.prototype.loadLinkedIn = function (){
  $("#new-assets-header").fadeOut(250, function(){
    $('.linked-in').fadeIn(250, function(){});
  })
}

var newAssets = new newAssetsView();

var bindNewAssetListeners = function(){
  $(document).on("click", '.asset-type-button', newAssets.toggleActiveAsset);
  $('#form-container').on("submit", 'form', newAssets.saveForm);
  $(document).on("click", "#import-assets-button", newAssets.loadLinkedIn)
}

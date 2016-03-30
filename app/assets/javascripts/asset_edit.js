var bindEditListeners = function (){
  $(document).on("click", '.edit-popup', editPopup );
  $(document).on("click", '.delete-popup', deletePopup);
}

var editPopup = function(event) {
  event.preventDefault();
  var assetType = event.currentTarget.dataset.assetType;
  var assetId = event.currentTarget.dataset.assetId;
  var uri = window.location.pathname.replace("/assets", "/" + assetType + "/" + assetId +"/edit");
  if (assetType === ("objectives")){
    tinyMCE.remove();
  };
  $.ajax({
    url: uri,
    method: "GET"
  })
  .done(function(response){
    $('#form-container-edit').html(response);
    addTags();
    dialog.dialog("open");
    $('.form-submit').remove();
    form = dialog.find("form").on("submit", function(event){
      event.preventDefault();
      editAsset(assetType,assetId);
    });
    if (assetType === ("objectives")) {
      setTimeout(function(){
        tinyMCE.activeEditor.focus()
      }, 250)
    };
  })

  dialog = $("#edit-form").dialog({
    autoOpen: false,
    modal:true,
    width:  725,
    height: 650,
    dialogClass : "modal-lg",
    buttons: {
      "Update": { text: "Update",
                  class: "btn btn-default",
                  click: function(){
                    editAsset(assetType, assetId);
                  },
      },
      Cancel: {   text: "Cancel",
                  class: "btn btn-default",
                  click: function(){
                    dialog.dialog("close");
                  },
      },
    },
    close: function(){
        if (assetType === ("objectives")){
          tinyMCE.remove();
        };
    }
  });
};

var editAsset = function(assetType, assetId) {
  var assetToUpdate = "#" + assetType + "_" + assetId;
  if (assetType === "objectives") {
    tinyMCE.triggerSave();
  }
  var uri = $('form').attr('action');
  var data = $('form').serialize();
  $.ajax({
    url: uri,
    method: "Put",
    data: data
  })
  .done(function(response) {
    $(assetToUpdate).html(response);
    dialog.dialog("close");
    // editTags(assetType,assetId);
    getUserTags();
  });
}

var editTags = function(assetType, assetId) {
  var tagObject = {taggable_type: capitalizeFirstLetter(assetType.slice(0, -1)), taggable_id: assetId};
  tagObject["tag_names"] = $('input#tags')[0].value;
  var data = {tagging: tagObject};
  var uri = window.location.pathname.replace("/assets", "");
  var uri = uri + "/taggings";
  $.ajax({
    url: uri,
    method: "POST",
    data: data
  })
  .done(function(response){
    getUserTags();
  });
};

var getUserTags = function() {
  var uri = window.location.pathname.replace("/assets", "/tags");
  $.ajax({
    url: uri,
    method:"GET"
  })
  .done(function(response){
    $("#tag-buttons").html(response);
  })
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

var deletePopup = function(event) {
  event.preventDefault();
  $("#delete-confirm").show();
  var assetId = event.currentTarget.dataset.assetId;
  var assetType = event.currentTarget.dataset.assetType;
  var uri = window.location.pathname.replace("/assets", "/" +assetType + "/" + assetId );

  deleteDialog = $("#delete-confirm").dialog({
    resizable:false,
    height:200,
    modal:true,
    buttons:{
      "Delete": function(){
        deleteAsset(assetType, assetId)
        $(this).dialog("close");
      },
      Cancel: function() {
        $(this).dialog("close");
      }
    }
  });
  deleteDialog.dialog.open;
}

var deleteAsset = function(assetType, assetId) {
  var assetToDelete = "#" + assetType + "_" + assetId;
  var uri = window.location.pathname.replace("/assets", "/" +assetType + "/" + assetId );
  $.ajax({
    url: uri,
    method: "DELETE"
  })
  .done(function(response) {
    $(assetToDelete).remove();
  });
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

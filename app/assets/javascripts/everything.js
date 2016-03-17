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

// ASSET INDEX ASSET INDEX ASSET INDEX ASSET INDEX ASSET INDEX ASSET INDEX
var bindAssetListeners = function() {
  $(document).on("click", '.tag-button', toggleTag );
  $(document).on("click", '.asset-resume', addAsset );
}

var bindAssetDescriptionListeners = function() {
  $(document).on("click", '.asset-check-box', assetDescriptionCheckbox);
}

var toggleTag = function(e) {
  e.preventDefault();
  var tagID = $(this).attr("tag_id");
  $(this).toggleClass("button-selected");
  var visible = $(this).hasClass("button-selected");
  toggleAssets(tagID, visible);
}

var toggleAssets = function(tagID, visible) {
  var assetDivs = $(".asset-container");
  for (var i = 0; i < assetDivs.length; i++) {
    if ($(assetDivs[i]).attr("tags").includes("|" + tagID + "|") == true) {
      if (visible === true) {
        $(assetDivs[i]).show();
      }
      else {
        $(assetDivs[i]).hide();
      }
    }
  }
}

var addAsset = function(e, buttonPassed) {
  console.log("Add Asset Button Clicked");
  var button
  if (buttonPassed) {
    button = buttonPassed;
  }
  else
  {
    e.preventDefault();
    button = $(this);
  }
  button.blur();
  var resumeId = $('#resumeID').attr("resume_id");
  var dataAssetId = button.attr("data-asset-id");
  var dataAssetType = button.attr("data-asset-type");
  var checkboxes = $("." + dataAssetType + "-" + dataAssetId + "-descriptions");
  var selectedDescriptions = [];
  for (var i = 0; i < checkboxes.length; i++) {
    if ($(checkboxes[i]).is(':checked')) {
      selectedDescriptions.push(checkboxes[i].value);
    }
  }
  var data = {
    current_user_id: button.attr("current_user_id"),
    data_asset_id: dataAssetId,
    data_asset_type: dataAssetType,
    selected_descriptions: selectedDescriptions
  };
  $.ajax({
    accepts: "application/json",
    url: "/users/" + data.current_user_id + "/resumes/" + resumeId,
    method: "PATCH",
    data: data
  })
  .done(function(response) {
    console.log("Successful Patch");
    if (response["update_status"] === "added") {
      button.children('span').removeClass("glyphicon-plus");
      button.children('span').addClass("glyphicon-minus");
      button.prop("title","Remove from Resume");
      button.css("background-color", "#FFB200");
    }
    else {
      button.children('span').removeClass("glyphicon-minus");
      button.children('span').addClass("glyphicon-plus");
      button.prop("title","Add to Resume");
      button.css("background-color", "");
    }
  })
  .fail(function(response) {
    console.log("Failed Patch");
    console.log(response);
  })
}

var assetDescriptionCheckbox = function(e) {
  console.log("Asset Description Clicked");
  var parentDiv = $(this).parents("div#" + $(this).attr("parent_class"));
  var button = $("#" + parentDiv.attr("id") + " button.asset-resume");
  if ($("#" + parentDiv.attr("id") + " button.asset-resume span").hasClass("glyphicon-minus")) {
    addAsset(e, button);
  }
}

// END ASSET INDEX END ASSET INDEX END ASSET INDEX END ASSET INDEX
// DETAIL EVENTS DETAIL EVENTS DETAIL EVENTS DETAIL EVENTS DETAIL EVENTS

var bindDetailEvents = function (){
  $(document).on("click", '#add_detail', AddDetailInput);
  $(document).on("click", '#remove_detail', RemoveDetailInput);
}

var AddDetailInput = function(e) {
    e.preventDefault();
    console.log ("detail add");
    var row = $('.detail').last().clone().val('');
    $('#add_detail').before(row);
};
var RemoveDetailInput = function(e) {
    e.preventDefault();
    if ($( ".detail" ).length > 1) {
      var row = $('.detail').last().remove();
    }
};
// END DETAIL EVENTS END DETAIL EVENTS END DETAIL EVENTS END DETAIL EVENTS
// ASSET EDIT ASSET EDIT ASSET EDIT ASSET EDIT ASSET EDIT ASSET EDIT

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
  $.ajax({url: uri, method: "GET"}).done(function(response){
        $('#form-container-edit').html(response);
        editTagsAutoComplete();
        dialog.dialog("open");
    $('.form-submit').remove();
    tagNames = $('#tags-names').attr("data-tag-names").trim();
    $("#tags").val(tagNames);

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
    width:  700,
    height: 650,
    dialogClass : "modal-lg",
    buttons: {"Update":function (){
      editAsset(assetType, assetId);
    },
    Cancel: function(){
      dialog.dialog("close");
      }
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
  $.ajax({url: uri, method: "Put", data: data}).done(function(response) {
    $(assetToUpdate).html(response);
     dialog.dialog("close");
      editTags(assetType,assetId);
  }
    );

}

var editTagsAutoComplete = function(){
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
var editTags = function(assetType, assetId) {
  var tagObject = {taggable_type: capitalizeFirstLetter(assetType.slice(0, -1)), taggable_id: assetId};
  tagObject["tag_names"]=$('input#tags')[0].value;
  var data = {tagging: tagObject};
  var uri = window.location.pathname.replace("/assets", "");
  var uri = uri + "/taggings";
  console.log(uri);
  $.ajax({url: uri, method: "POST", data: data}).done(function(response){
    // console.log(response);
    getUserTags();
   });
};

var getUserTags = function() {
  var uri = window.location.pathname.replace("/assets", "/tags");
  $.ajax({url: uri, method:"GET"}).done(function(response){
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
  $.ajax({url: uri, method: "DELETE"}).done(function(response) {
    $(assetToDelete).remove();
  }
    );

}
// END ASSET EDIT END ASSET EDIT END ASSET EDIT END ASSET EDIT
// FINE TUNE FINE TUNE FINE TUNE FINE TUNE FINE TUNE FINE TUNE

var bindFineTuneListeners = function(){
  $(document).on("click", ".fine-tune-button", loadFineTuneForm);
}

var loadFineTuneForm = function(e){
  e.preventDefault();
  tinyMCE.remove();
  var data = $('.resume-template').html();
  var uri = $(this).attr("href");

  $.ajax({url: uri, method: "POST", data: {document_data: data}}).done(function(response){
    $("#resume-show-instructions").hide();
    $(".resume-fine-tune").show();
    $('.sortable-wrapper').html(response);
    setTimeout(function(){
      tinyMCE.activeEditor.setContent(data);
      tinyMCE.activeEditor.focus();
    }, 1000)
  })
}
// END FINE TUNE END FINE TUNE END FINE TUNE END FINE TUNE
// NEW ASSET NEW ASSET NEW ASSET NEW ASSET NEW ASSET NEW ASSET
var newAssetsView = function(){}



newAssetsView.prototype.loadForm = function(event){
  tinyMCE.remove();
  var uri = $(event.currentTarget).attr("href");
  $.ajax({url: uri, method: "GET", context: this}).done(function(response){
      $('#form-container').html(response);
    setTimeout(function(){
      $('#form-container').fadeIn(250, function(){
        newAssets.addTags();
        //animation here
      })
    },250)
  })
}

newAssetsView.prototype.saveForm = function(event){
  event.preventDefault();
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


newAssetsView.prototype.toggleActiveAsset = function(e){
    e.preventDefault();
    $(e.target.parentNode.children).removeClass("button-selected");
    $(e.target).addClass("button-selected");
    $(e.target).blur();
    $('.saved').fadeOut(250, function(){
            //animation complete
    })
    newAssets.loadForm(e);
}

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

var newAssets = new newAssetsView();

var bindNewAssetListeners = function(){
  $(document).on("click", '.asset-type-button', newAssets.toggleActiveAsset);
  $('#form-container').on("submit", 'form', newAssets.saveForm);
}
// END NEW ASSET END NEW ASSET END NEW ASSET END NEW ASSET END NEW ASSET
// RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW
var bindResumeShowListeners = function (){
  addSortable();

  $(document).on('click', '#print-resume-button', printResume);
  $(document).on('click', '#save-resume-button', saveSortedResume);
  $(document).on('mouseup', '.asset-portlet', changeResumeSize)
  $(document).on('sortupdate', '#trashcan', deleteResumeAsset)
}

var addSortable = function(){
  $('.resume-content').sortable({
    connectWith: ".resume-content",
    handle: '.asset-portlet-header',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })

  $('.nested-sort').sortable({
    connectWith: ".nested-sort",
    handle: '.panel-heading',
    placeholder: "portlet-placeholder ui-corner-all",
    tolerance: "pointer"
  })
  $( ".resume-template" ).resizable();
}

var deleteResumeAsset = function(e){
  var selectedElement = $(e.toElement).parent()
  var selectedAsset = $(e.toElement).parent().find('.panel').attr("id").split("_")
  var data = {data_asset_type: selectedAsset[0], data_asset_id: selectedAsset[1]}
  var uri = window.location.href
  debugger;
  $.ajax({url: uri, method: "PATCH", data}).done(function(response){
    console.log(response)
    $(selectedElement).remove();
  })
}

var saveSortedResume = function(e){
    e.preventDefault();

    var assetNodes = $('.panel.panel-default')
    for(var i = 0; i < assetNodes.length; i++){

      var assetTypeId = assetNodes[i].id.split('_');
      var parentLocationId = assetNodes[i].parentNode.parentNode.parentNode.parentNode.id.split('_');
      var resumeId = $(this).attr("resume_id")
      var data = { asset_type: assetTypeId[0], asset_id: assetTypeId[1], div_sort: parentLocationId[1], resume_id: resumeId};

      $.ajax({
        url: "/users/" + $(this).attr("current_user_id") + "/resume_assets/" + data.asset_id,
        method: "PATCH",
        data: data,
        dataType: 'json'
      }).done(function(response){
        console.log('success');
      }).fail(function(response){
        console.log('fail');
      });
    }
  }
var changeResumeSize = function(){
  var sections = $('.resume-section')
  for (var i =0 ; i < sections.length; i++){
    var sectionCount = sections[i].children.length;
    if (sectionCount > 6){
      sections[i].style.height = '100%'
    } else {
      sections[i].style.height = ''
    }
  }
 }

// END RESUME SHOW END RESUME SHOW END RESUME SHOW END RESUME SHOW
// RESUME INDEX RESUME INDEX RESUME INDEX RESUME INDEX RESUME INDEX
var bindResumeIndexListeners = function() {
  $(document).on("click", '#new-resume-button', newResume);
}

var newResume = function(e) {

  e.preventDefault();
  var userlink = $('#user_info a')[0].href;
  var userId = userlink.match(/\d*$/);

  $.ajax({
    url: "/users/" + userId + "/resumes/new",
    method: "GET"
  })
  .done(function(response) {
    $('div#new-resume-form').append(response);
    $('#new-resume-button').fadeOut(250, function(){
      //
    });
    $('#dashboard-instructions').fadeOut(250, function(){
      $('div#new-resume-form').fadeIn(250);
    })
  })
  .fail(function(response) {
  })
}

// END RESUME INDEX END RESUME INDEX END RESUME INDEX END RESUME INDEX
// USER SHOW PAGE USER SHOW PAGE USER SHOW PAGE USER SHOW PAGE USER SHOW PAGE
var bindWebsiteListeners = function() {
  $(document).on("click", '#new-website-button', newWebsite);
  $(document).on('submit', '#new-website-form', submitWebsite)
  $(document).on('click', '.delete-website', deleteWebsite)
}

var newWebsite = function(e) {
  e.preventDefault();
  var userId = this.attributes.user_id.value;
  $.ajax({
    url: "/users/" + userId + "/websites/new",
    method: "GET"
  })
  .done(function(response) {
    $('#new-website-form').append(response);
    $('#new-website-button').prop("disabled",true);
  }).fail(function(response) {
    console.log("Failed GET");
  })
}

var submitWebsite = function(e) {
  e.preventDefault();
  var userId = $('#new-website-button')[0].attributes.user_id.value;
  var data = $("#new_website").serialize();
  console.log(data);
  $.ajax({
    url: "/users/" + userId + "/websites",
    method: "POST",
    data: data
  }).done(function(response) {
    var data = response
    var template = $('#individual-template')[0].innerHTML
    var compileTemplate = Handlebars.compile(template);
    var compiler = compileTemplate(data);
    $('#user-information tbody').append(compiler);
    $('#new-website-form form').remove();
    $('#new-website-button').prop("disabled",false);

  }).fail(function(response) {
    console.log("Failed GET");
  })
}

var deleteWebsite = function(e) {
  e.preventDefault();
  var websiteID = this.attributes.website_id.value;
  var userId = $('#new-website-button')[0].attributes.user_id.value;
  $.ajax({
    url: '/users/'+ userId + '/websites/'+ websiteID,
    method: 'Delete'
  }).done(function(response){
    $("#website_"+websiteID).remove();
  }).fail(function(response){
    console.log(response);
  })

}
// END USER SHOW PAGE END USER SHOW PAGE END USER SHOW PAGE END USER SHOW PAGE

$(document).ready(function(){
  console.log("hello!");
  bindAssetListeners();
  bindDetailEvents();
  bindEditListeners();
  bindFineTuneListeners();
  bindNewAssetListeners();
  bindResumeShowListeners();
  bindResumeIndexListeners();
  openingAnimation();
  bindWebsiteListeners();
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
  $('.asset-resume').on("click", addAsset );
}

var toggleTag = function(e) {
  e.preventDefault();
  var tagID = $(this).attr("tag_id");
  $(this).toggleClass("button-selected");
  var visible = $(this).hasClass("button-selected");
  toggleAssets(tagID, visible);
}

var toggleAssets = function(tagID, visible) {
  console.log(tagID);
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

var addAsset = function(e) {
  e.preventDefault();
  console.log("Add Asset Button Clicked");
  console.log(this);
  var button = $(this);
  var resumeId = $('#resumeID').attr("resume_id");
  console.log(resumeId);
  var data = {
    current_user_id: $(this).attr("current_user_id"),
    data_asset_id: $(this).attr("data-asset-id"),
    data_asset_type: $(this).attr("data-asset-type"),
  };
  console.log(data);
  debugger;
  $.ajax({
    accepts: "application/json",
    url: "/users/" + data.current_user_id + "/resumes/" + resumeId,
    method: "PATCH",
    data: data
  })
  .done(function(response) {
    console.log("Successful Patch");
    console.log(response);
    if (response["update_status"] === "added") {
      button.children('span').removeClass("glyphicon-plus");
      button.children('span').addClass("glyphicon-minus");
      button.prop("title","Remove from Resume");
    }
    else {
      button.children('span').removeClass("glyphicon-minus");
      button.children('span').addClass("glyphicon-plus");
      button.prop("title","Add to Resume");
    }
  })
  .fail(function(response) {
    console.log("Failed Patch");
    console.log(response);
  })
}
// END ASSET INDEX END ASSET INDEX END ASSET INDEX END ASSET INDEX
// DETAIL EVENTS DETAIL EVENTS DETAIL EVENTS DETAIL EVENTS DETAIL EVENTS

var bindDetailEvents = function (){
  $('body').on("click", '#add_detail', AddDetailInput);
  $('body').on("click", '#remove_detail', RemoveDetailInput);

}

var AddDetailInput = function(e) {
  e.preventDefault();
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
  $('body').on("click", '.edit-popup', editPopup );
  $('body').on("click", '.delete-popup', deletePopup);
  $("#delete-confirm").hide()
}

var editPopup = function(event) {
  event.preventDefault();
  var assetType = event.currentTarget.dataset.assetType;
  var assetId = event.currentTarget.dataset.assetId;
  var uri = window.location.pathname.replace("/assets", "/" + assetType + "/" + assetId +"/edit");


  dialog = $("#edit-form").dialog({
    autoOpen: false,
    modal:true,
    width:  700,
    height: 650,
    dialogClass : "modal-lg",
    "Close": function() {
                  $(this).dialog("close");
                  $('#form-container-edit').html("");
              },

    buttons: {"Update":function (){
      editAsset(assetType, assetId);
    }}
  });
  dialog.dialog("open");
  tinyMCE.remove();
  $.ajax({url: uri, method: "GET"}).done(function(response){
        $('#form-container-edit').html(response);
    $('.form-submit').remove()
    tagNames = $('#tags-names').attr("data-tag-names").trim()
    $("#tags").val(tagNames)
    form = dialog.find("form").on("submit", function(event){
      event.preventDefault();
      editAsset(assetType,assetId);
          })

  });
   };

var editAsset = function(assetType, assetId) {
  var assetToUpdate = "#" + assetType + "_" + assetId;
  var uri = $('form').attr('action');
  var data = $('form').serialize();
  $.ajax({url: uri, method: "Put", data: data}).done(function(response) {
    dialog.dialog("close");
    $(assetToUpdate).html(response);
     editTags(assetType,assetId);
  }
    );

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
  var assetId = event.currentTarget.dataset.assetId;
  var assetType = event.currentTarget.dataset.assetType;
  var uri = window.location.pathname.replace("/assets", "/" +assetType + "/" + assetId );
  console.log(uri);
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
  $("body").on("click", ".fine-tune-button", loadFineTuneForm);
}

var loadFineTuneForm = function(e){
  e.preventDefault();
  var data = $('.resume-template').html()
  var uri = $(this).attr("href")
  $.ajax({url: uri, method: "POST", data: {document_data: data}}).done(function(response){
    $("#resume-show-instructions").hide()
    $(".resume-fine-tune").show()
    $('.sortable-wrapper').html(response)
    setTimeout(function(){
      tinyMCE.activeEditor.setContent(data)
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
  $('.asset-type-button').on("click", newAssets.toggleActiveAsset);
  $('#form-container').on("submit", 'form', newAssets.saveForm);
}
// END NEW ASSET END NEW ASSET END NEW ASSET END NEW ASSET END NEW ASSET
// RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW
var bindResumeShowListeners = function (){
  addSortable();
  $('#save-resume-button').on('click', saveSortedResume);
  $('.asset-portlet').on('mouseup', changeResumeSize)

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

var saveSortedResume = function(e){
    e.preventDefault();
    console.log('Save resume button')
    // save to database as template
    var resumeTemplate = $('.resume-template')[0].innerHTML
    // debugger;
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
    // debugger;
  for (var i =0 ; i < sections.length; i++){
    var sectionCount = sections[i].children.length;
    if (sectionCount > 6){
      sections[i].style.height = '100%'
      console.log('making heigh 100')
    } else {
      sections[i].style.height = ''
      console.log('making heigh blank')
    }
  }
 }

// END RESUME SHOW END RESUME SHOW END RESUME SHOW END RESUME SHOW
// RESUME INDEX RESUME INDEX RESUME INDEX RESUME INDEX RESUME INDEX
var bindResumeIndexListeners = function() {
  $('#new-resume-button').on("click", newResume);
}

var newResume = function(e) {
  e.preventDefault();
  var userId = $('.navbar-text').attr("user_id");
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
  $('#new-website-button').on("click", newWebsite);
  $('#new-website-form').on('submit', 'form', submitWebsite)
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

  var data = $(this).serialize();
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
// END USER SHOW PAGE END USER SHOW PAGE END USER SHOW PAGE END USER SHOW PAGE

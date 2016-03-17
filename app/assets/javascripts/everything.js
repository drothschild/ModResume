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



// END FINE TUNE END FINE TUNE END FINE TUNE END FINE TUNE
// NEW ASSET NEW ASSET NEW ASSET NEW ASSET NEW ASSET NEW ASSET
var newAssetsView = function(){}



newAssetsView.prototype.loadForm = function(event){
  var uri = $(event.currentTarget).attr("href");
  $.ajax({url: uri, method: "GET", context: this}).done(function(response){
    setTimeout(function(){
      tinyMCE.remove();
      $('#form-container').html(response);
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
    $('#form-container').fadeOut(250, function(){
      //animation complete
    })
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

newAssetsView.prototype.loadLinkedIn = function (){
  console.log("click")
  $("#new-assets-header").fadeOut(250, function(){
    $('.linked-in').fadeIn(250, function(){
      //animation complete
    })
  })
}

var newAssets = new newAssetsView();

var bindNewAssetListeners = function(){
  $(document).on("click", '.asset-type-button', newAssets.toggleActiveAsset);
  $('#form-container').on("submit", 'form', newAssets.saveForm);
  $(document).on("click", "#import-assets-button", newAssets.loadLinkedIn)
}
// END NEW ASSET END NEW ASSET END NEW ASSET END NEW ASSET END NEW ASSET
// RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW RESUME SHOW
var bindResumeShowListeners = function (){
  addSortable();


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
  $(document).on('click', '#print-resume-button', printResume);
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

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
  })
  .fail(function(response) {
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
  })
  .done(function(response) {
    var data = response
    var template = $('#individual-template')[0].innerHTML
    var compileTemplate = Handlebars.compile(template);
    var compiler = compileTemplate(data);
    $('#user-information tbody').append(compiler);
    $('#new-website-form form').remove();
    $('#new-website-button').prop("disabled",false);

  })
  .fail(function(response) {
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
  })
  .done(function(response){
    $("#website_"+websiteID).remove();
  })
  .fail(function(response){
    console.log(response);
  })
}

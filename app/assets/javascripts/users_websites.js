$(document).ready(function() {
  bindWebsiteListeners();
});

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



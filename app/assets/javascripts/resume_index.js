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
    $('#new-resume-button').fadeOut(250, function(){});
    $('#dashboard-instructions').fadeOut(250, function(){
      $('div#new-resume-form').fadeIn(250);
    })
  })
  .fail(function(response) {
  })
}

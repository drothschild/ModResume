$(document).ready(function(){
  bindEvents();
});


var bindEvents = function (){
  $('body').on("click", '#add_detail', AddDetailInput);

}
var AddDetailInput = function(e) {
  e.preventDefault();
    var row = $('.detail').clone();
    $('#add_detail').before(row);
};
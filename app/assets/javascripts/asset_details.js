var bindDetailEvents = function (){
  $(document).on("click", '#add_detail', AddDetailInput);
  $(document).on("click", '#remove_detail', RemoveDetailInput);
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

//= require turbolinks
//= require jquery
//= require jquery-ui

function copyclipboard() { 
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val($('#order-id').text()).select();
  document.execCommand("copy");
  alert('copied');
}
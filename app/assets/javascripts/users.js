//= require turbolinks
//= require jquery
//= require jquery-ui
function trigger_file() {
   $("#user_photo").trigger('click');
}

$(function(){
  $('#user_photo').change(function(){
    var input = this;
    var url = $(this).val();
    alert(url);
    var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
    if (input.files && input.files[0]&& (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) 
     {
        var reader = new FileReader();

        reader.onload = function (e) {
           $('#img').attr('src', e.target.result);
        }
       reader.readAsDataURL(input.files[0]);
    }
    else
    {
      $('#img').attr('src', '/assets/no_preview.png');
    }
  });

});
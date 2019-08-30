//= require turbolinks
//= require jquery
//= require jquery-ui

function currencyFormat(num) {
  return 'Rp.' + num.toFixed(0).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
}

$(document).on('turbolinks:load', function () {
  if ($('.pagination').length && $('#search-output-table').length) {
    $(window).scroll(function() {
      var url = $('.pagination .page-item:last a').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $.getScript(url);
        $('.pagination').text("Menampilkan lebih banyak Campaign");
      }
    });
    $(window).scroll();
  }
});
function show_filter(){
  $('#collapseExample').animate({height: "toggle"}, 300);
}
$(document).on('turbolinks:load', function() {
    var slider = $("#the_slider").slider({
        range: true,
        min: 0,
        max: 100,
        values: [0, 100],
        slide: function(event, ui) {
            $("#data1").val(currencyFormat(ui.values[0] * 10000000));
            $("#data2").val(currencyFormat(ui.values[1] * 10000000));
        }
    });
    $("#data1").val(currencyFormat(slider.slider("values")[0] * 10000000));
    $("#data2").val(currencyFormat(slider.slider("values")[1] * 10000000));
});

function show_snap(campaign_id, token){
  snap.pay(token, {
    onSuccess: function(res) { $.ajax({
      url: "/campaigns/save-donation/" + campaign_id,
      type: "POST"
    }); },
    // you may also implement:
    // onPending
    onError: function(res) { alert("Error Donasi dibatalkan");},
  });
}

function amount_check(donation_needed){
  var amount = $('.donation_campaign').eq(0).val();
  var donation_message = null;
    if (amount < 1000){
      donation_message = "Minimal donasi yang dimasukkan adalah Rp.1.000";
    }
    else if ( amount % 1000 != 0){
      donation_message = "Donasi harus berkelipatan ribuan";
    }
    else if (amount > donation_needed){
      donation_message = "Batas donasi yang dimasukkan sejumlah " + currencyFormat(donation_needed);
    }
    else{
      donation_message = null;
    }
    if(amount == ""){
      donation_message = null;
    }
    if (!donation_message){
      $('#submit').attr("disabled", false);
      $('#donation-hint').css('opacity','0');
    }
    else{
      $('#donation-hint').text(donation_message);
      $('#submit').attr("disabled", true);
      $('#donation-hint').css('opacity','1');
    }
}

function trigger_campaign_file() {
   $("#campaign_image_campaign").trigger('click');
}

$(function(){
  $('#campaign_image_campaign').change(function(){
    var input = this;
    var url = $(this).val();
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
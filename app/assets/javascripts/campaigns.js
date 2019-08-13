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
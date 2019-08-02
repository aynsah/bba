//= require jquery
//= require jquery-ui
//= require jquery_ujs

function currencyFormat(num) {
  return 'Rp.' + num.toFixed(0).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
}

$(document).ready(function () {
  if ($('.pagination').length && $('#search-output-table').length) {
    $(window).scroll(function() {
      var url = $('.pagination .page-item:last a').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $.getScript(url);
        $('.pagination').text("Loading more Campaigns");
      }
    });
    $(window).scroll();
  }
});

$(document).ready(function() {
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
//= require jquery

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
            $("#data1").val(ui.values[0] * 10000000);
            $("#data2").val(ui.values[1] * 10000000);
        }
    });
    $("#data1").val(slider.slider("values")[0] * 10000000);
    $("#data2").val(slider.slider("values")[1] * 10000000);
});
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
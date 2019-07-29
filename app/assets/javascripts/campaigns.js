//= require jquery

$(document).ready(function () {
  if ($('.pagination').length && $('#search-output-table').length) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        alert("Hello");
        $('.pagination').text("Loading more Campaigns");
        $.getScript(url);
      }
    });
    $(window).scroll();
  }
});
$ ->
  if $('.pagination').length && $('#search-output-table').length
    $(window).scroll ->
      more_posts_url = $('.pagination .next_page').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').text("Loading more Campaigns")
        $.getScript(url)
    $(window).scroll()
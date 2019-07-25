# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  if $('.pagination').length && $('#search-output-table').length
    $(window).scroll ->
      more_posts_url = $('.pagination .next_page').attr('href')
        if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
            $('.pagination').text("Loading more Campaigns")
            $.getScript url
    $(window).scroll()
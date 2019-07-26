$(document).ready ->
  alert "Hello"
  $(document).on "change", "#status-doa select" , ->
    alert "Hello"
    $.ajax '/doas/change-status/' + this.parentElement.id,
      type: 'GET'
      error: (jqXHR, textStatus, errorThrown) ->
        console.error 'AJAX Error: '
      success: (data, textStatus, jqXHR) ->
        console.log textStatus
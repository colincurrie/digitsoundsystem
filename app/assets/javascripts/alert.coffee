$(document).on 'page:change', ->
  $(".alert").fadeTo 500, 1
  delay = (ms, func) -> setTimeout func, ms
  delay 5000, ->
    $(".alert").fadeTo 2000, 0

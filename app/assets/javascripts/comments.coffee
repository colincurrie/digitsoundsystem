# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'page:change', ->
  $(".add_comment").click ->
    form = this.parentElement.querySelector(".new_comment")
    form.style.display = if form.style.display == 'none' then 'block' else 'none'
    # TODO: why doesn't this work?
    # $('#comment_content').focus

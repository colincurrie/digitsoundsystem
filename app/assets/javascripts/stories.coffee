# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# If JS is enabled add a class so we can hide the form ASAP (and only for JS enabled browsers)
document.documentElement.className = 'js'

$(document).on 'page:change', ->
  # show the form if there are errors or this the edit page
  $("#story_form").show() if $("#story_form .field_with_errors, #edit_story").length>0
  # also hide the 'new story' link if this is the edit page
  $(".new_story").hide() if $("#edit_story").length>0

  # hide all the comment forms
  for form in $(".new_comment")
    form.style.display = 'none'

  # add the jQuery click / show / hide behaviours:
  $(".new_story").click ->
    if $("#story_form").is(":visible")
      $("#story_form").hide()
    else
      $("#story_form").show()
    false
  $(".add_comment").click ->
    form = this.parentElement.querySelector(".new_comment")
    console.log("debug")
    form.style.display = if form.style.display == 'none' then 'block' else 'none'

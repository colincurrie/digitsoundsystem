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

  # initialise the image input selector
  btn_text = if $('#preview img').length > 0 then 'Update Image' else 'Add Image'
  $(":file").filestyle { badge: "false", buttonText: btn_text }

  $('#story_image').on 'change', (event) ->
    files = event.target.files
    image = files[0]
    reader = new FileReader
    reader.onload = (file) ->
      img = new Image
      img.src = file.target.result
      img.height = 300
      $('#preview').html img

    reader.readAsDataURL image

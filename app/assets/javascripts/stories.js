/*
 * decaffeinate suggestions:
 * DS101: Remove unnecessary use of Array.from
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// If JS is enabled add a class so we can hide the form ASAP (and only for JS enabled browsers)
document.documentElement.className = 'js';

$(document).on('page:change', function() {
  // show the form if there are errors or this the edit page
  if ($("#story_form .field_with_errors, #edit_story").length>0) { $("#story_form").show(); }
  // also hide the 'new story' link if this is the edit page
  if ($("#edit_story").length>0) { $(".new_story").hide(); }

  // hide all the comment forms
  for (let form of Array.from($(".new_comment"))) {
    form.style.display = 'none';
  }

  // add the jQuery click / show / hide behaviours:
  $(".new_story").click(function() {
    if ($("#story_form").is(":visible")) {
      $("#story_form").hide();
    } else {
      $("#story_form").show();
    }
    return false;
  });

  // initialise the image input selector
  const btn_text = $('#preview img').length > 0 ? 'Update Image' : 'Add Image';
  $(":file").filestyle({ badge: "false", buttonText: btn_text });

  return $('#story_image').on('change', function(event) {
    const {
      files
    } = event.target;
    const image = files[0];
    const reader = new FileReader;
    reader.onload = function(file) {
      const img = new Image;
      img.src = file.target.result;
      img.height = 300;
      return $('#preview').html(img);
    };

    return reader.readAsDataURL(image);
  });
});

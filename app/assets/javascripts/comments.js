/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('page:change', () => $(".add_comment").click(function() {
  const form = this.parentElement.querySelector(".new_comment");
  return form.style.display = form.style.display === 'none' ? 'block' : 'none';
}));
    // TODO: why doesn't this work?
    // $('#comment_content').focus

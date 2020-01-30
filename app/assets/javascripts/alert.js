/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
$(document).on('page:change', function() {
  $(".alert").fadeTo(500, 1);
  const delay = (ms, func) => setTimeout(func, ms);
  return delay(5000, () => $(".alert").fadeTo(2000, 0));
});

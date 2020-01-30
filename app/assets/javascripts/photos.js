/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
$(document).on('page:change', function() {
  // initialise the image input selector
  const btn_text = $('#preview img').length > 0 ? 'Update Photo' : 'Add Photo';
  $(":file").filestyle({badge: "false", buttonText: btn_text});

  return $('input#photo_image').on('change', function(event) {
    console.log('debug here');
    const {
      files
    } = event.target;
    const image = files[0];
    const reader = new FileReader;
    reader.onload = function(file) {
      const img = new Image;
      img.src = file.target.result;
      img.width = 900;
      return $('#preview').html(img);
    };

    return reader.readAsDataURL(image);
  });
});

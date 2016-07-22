$(document).on 'page:change', ->
  # initialise the image input selector
  btn_text = if $('#preview img').length > 0 then 'Update Photo' else 'Add Photo'
  $(":file").filestyle {badge: "false", buttonText: btn_text}

  $('input#photo_image').on 'change', (event) ->
    console.log 'debug here'
    files = event.target.files
    image = files[0]
    reader = new FileReader
    reader.onload = (file) ->
      img = new Image
      img.src = file.target.result
      img.width = 900
      $('#preview').html img

    reader.readAsDataURL image

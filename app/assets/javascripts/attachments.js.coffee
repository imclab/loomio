jQuery ->

  $(document).on 'click', '#add-attachment-icon', ->
    $('input:file').trigger('click')



  $('#fileupload').fileupload
    add: (e, data) ->
      types = /(\.|\/)(exe)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        alert("#{file.name} is an .exe file, which is not allowed")
      else
        data.context = $(tmpl("template-upload", file))
        $('#fileupload').append(data.context)
        $('#fileupload').data('filesize', data.files[0].size)
        $('#fileupload').data('filename', data.files[0].name)
        data.submit()

    
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    
    done: (e, data) ->
      file = data.files[0]
      domain = $('#fileupload').attr('action')
      path = $('#fileupload input[name=key]').val().replace('${filename}', file.name)
      to = $('#fileupload').data('post')
      content = {}
      content[$('#fileupload').data('as')] = domain + path
      content['attachment[filesize]'] = $('#fileupload').data('filesize')
      content['attachment[filename]'] = $('#fileupload').data('filename')
      $.post(to, content)
      data.context.remove() if data.context # remove progress bar
    
    fail: (e, data) ->
      alert("#{data.files[0].name} failed to upload.")
      console.log("Upload failed:")
      console.log(data)




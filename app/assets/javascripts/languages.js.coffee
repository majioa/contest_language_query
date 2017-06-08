# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#
(($) ->
  $.fn.extend donetyping: (callback, timeout) ->
    timeout = timeout or 1e3
    # 1 second default timeout
    timeoutReference = undefined

    doneTyping = (el) ->
      if !timeoutReference
        return
      timeoutReference = null
      callback.call el
      return

    @each (i, el) ->
      $el = $(el)
      # Chrome Fix (Use keyup over keypress to detect backspace)
      # thank you @palerdot
      $el.is(':input') and $el.on('keyup keypress paste', (e) ->
        # This catches the backspace button in chrome, but also prevents
        # the event from triggering too preemptively. Without this line,
        # using tab/shift+tab will make the focused element fire the callback.
        if e.type == 'keyup' and e.keyCode != 8
          return
        # Check if timeout has been set. If it has, "reset" the clock and
        # start over again.
        if timeoutReference
          clearTimeout timeoutReference
        timeoutReference = setTimeout((->
          # if we made it here, our timeout has elapsed. Fire the
          # callback
          doneTyping el
          return
        ), timeout)
        return
      ).on('blur', ->
        # If we can, fire the event since we're leaving the field
        doneTyping el
        return
      )
      return
  return
) jQuery

$(document).ready ->
  $('input#request').donetyping ->
    valuesToSubmit = $('form').serialize()
    request =
      type: "POST"
      url: $('form').attr('action') + '.js'
      data: valuesToSubmit
      dataType: "script"

    $.ajax(request).success ->
      console.log "success", js
      return
    return
  return

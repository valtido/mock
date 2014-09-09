#notifications
(($, undefined_) ->
  "use strict"
  types = [ "error", "success", "notice", "warning", "danger", "information" ]
  icons =
    error: "sm-icon-error"
    success: "sm-icon-check"
    notice: "sm-icon-eye"
    warning: "sm-icon-attention"
    danger: "sm-icon-block"
    information: "sm-icon-info-circled"

  delay = 5000
  defaults =
    auto_remove: true
    speed: 750

  $.notification = (type, message, options) ->
    "use strict"
    if !message
      message = 'Error: Unknown error occured.'
    get_defaults = $.extend(true, {}, defaults)
    get_defaults.auto_remove = false  if type is "warning"
    options = $.extend(get_defaults, options) #merge options with defaults.
    clear_messages = (event) ->
      target = $(this).add($(this).parents(".notification"))
      is_clicked = event.type is "click"
      type = event.type
      if options.auto_remove is true or (type isnt 'undefined' and is_clicked)
        target.stop(true, true).slideUp(options.speed).remove().dequeue()
        parent.hide()  if parent.children().length is 0
      else
        target.stop true, true

    app = $("body")
    parent = app.children(".notifications") #top wrapper
    #all notifications currently displaying.
    notifications = parent.children(".notification")
    notification = $("<div></div>", # notification to be added.
      class: "notification"
    )
    close_button = $("<i></i>",
      class: "sm-icon-cancel close_button"
    )
    icon = $("<i></i>",
      class: icons[type] or "sm-icon-error"
    )
    parent.show()
    unless parent.length is 1
      parent.remove()
      parent = $("<div></div>",
        class: "notifications"
      )
      app.prepend parent
    if $.inArray(type, types) is -1
      throw Error "Type is missing or not found in the available types."
    return false  if message is 'undefined'
    close_button.click clear_messages
    text = type.substr(0, 1).toUpperCase() + type.substr(1) + ": "

    # .text(text)
    icon.addClass("sm-icon").css "display", "inline"
    notification.hide().addClass type

    #check if there are multiple messages to display or just the one.
    #if it's array it will display a list of messages wrapped with a div
    if $.isArray(message)
      if message.length > 0
        $.each message, (i, n) ->
          if n and typeof n is "object" and (typeof n.field isnt "undefined")
            context = options.form or document
            field = $(":input[name=\"" + n.field + "\"]", context)
            msg = n.msg
            is_position = typeof n.position isnt "undefined"
            position = (if is_position then n.position else 0)
            field.addClass "highlight"
            field.on "blur change advancedbox_changed", ->
              first_attempt = $(this).parent()
                              .find(".server_validation_error")
              if first_attempt.length > 0
                first_attempt.remove()
              else
                $(this).parent().parent()
                .find(".server_validation_error").remove()

            div = $("<div/>",
              class: "validation-error"
              text: msg
            )
            if position > 0
              clone = div.clone().appendTo(field.eq(position - 1).parent())
            else
              clone = div.clone().appendTo(field.parent())
            clone.addClass "server_validation_error"
            notification.append div
          else
            child = $("<div></div>").text(n)
            notification.append child

    else if typeof message is "string"
      child = $("<div></div>").text(message)
      notification.append child
    else
      message = "Unknown problem."
      if window["console"]
        console.warn "A notification message should be a string or a list."
    notification.appendTo(parent)
    .prepend(icon).append(close_button)
    .slideDown(options.speed).delay(delay)
    .queue clear_messages  if message.length > 0
) jQuery

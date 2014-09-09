describe "Notifications", ->
  beforeEach ->
    $('.notifications').empty()

  #error
  it "Should display an error message", ->
    message = "There was an error"
    $.notification "error", message
    expect($('.notifications .error div').length).toBe(1)

  it "Should display multiple error messages", ->
    message = ["There was an error","There was another error"]
    $.notification "error", message
    expect($('.notifications .error div').length).toBe(2)

  #success
  it "Should display a success message", ->
    message = "Success message"
    $.notification "success", message
    expect($('.notifications .success div').length).toBe(1)

  it "Should display multiple success messages", ->
    message = ["Success message","Message number 2"]
    $.notification "success", message
    expect($('.notifications .success div').length).toBe(2)

  #warning
  it "Should display a warning message", ->
    message = "warning message"
    $.notification "warning", message
    expect($('.notifications .warning div').length).toBe(1)

  it "Should display multiple warning messages", ->
    message = ["warning message","warning number 2"]
    $.notification "warning", message
    expect($('.notifications .warning div').length).toBe(2)


  #information
  it "Should display a information message", ->
    message = "information message"
    $.notification "information", message
    expect($('.notifications .information div').length).toBe(1)

  it "Should display multiple information messages", ->
    message = ["information message","information number 2"]
    $.notification "information", message
    expect($('.notifications .information div').length).toBe(2)


  #danger
  it "Should display a danger message", ->
    message = "danger message"
    $.notification "danger", message
    expect($('.notifications .danger div').length).toBe(1)

  it "Should display multiple danger messages", ->
    message = ["danger message","danger number 2"]
    $.notification "danger", message
    expect($('.notifications .danger div').length).toBe(2)

  #notice
  it "Should display a notice message", ->
    message = "notice message"
    $.notification "notice", message
    expect($('.notifications .notice div').length).toBe(1)

  it "Should display multiple notice messages", ->
    message = ["notice message","notice number 2"]
    $.notification "notice", message
    expect($('.notifications .notice div').length).toBe(2)


  ## EXPECT ERRORS WHEN it Goes wrong

  it "Should display error when messages is null", ->
    message = null
    $.notification "error", message
    expect($('.notifications .error div').length).toBe(1)
    expect($('.notifications .error div').text()).toBe("Error: Unknown error occured.")


  it "Should display error when messages is false", ->
    message = false
    $.notification "error", message
    expect($('.notifications .error div').length).toBe(1)
    expect($('.notifications .error div').text()).toBe("Error: Unknown error occured.")


  it "Should display error when messages is undefined", ->
    message = undefined
    $.notification "error", message
    expect($('.notifications .error div').length).toBe(1)
    expect($('.notifications .error div').text()).toBe("Error: Unknown error occured.")

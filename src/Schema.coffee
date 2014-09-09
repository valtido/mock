class Schema
  constructor: (config) ->
    if config
      for key, item of config
        #check if type is string, then translate it if is valid
        #e.g: new Schema({age : 'Person.Age'})
        if typeOf( item ) is "[object String]"
          if key is 'type'
            throw Error "Schema Error: The String of `#{key}` NEVER HERE."
          else
            if @exists item
              type = item
              config[key] = merge(@get_type(type) ,{type: type})
            else
              throw Error "Schema: `#{item}` of `#{key}` isn't a valid type"
        else if typeOf( item ) is "[object Object]"
          type = item.type
          # has type?
          if typeof type isnt 'undefined'
            # is it valid type?
            if not @exists type
              throw Error "Schema: Invalid schema type #{item} of `#{key}`"
            else
              config[key] =  merge(@get_type(type), item, {type: type})
          else
            config[key] = new Schema(item)
            # config[key].type = 'Schema'

        else
          throw Error "Schema: Unknown schema Type `#{item}` of `#{key}`"
    else
      throw Error "Schema Error: You must provide an object"
    config.type = 'Schema'
    return config

  get_type : (str) ->
    arr = @types
    if typeof str isnt 'string' then return false
    parts = str.split(".")
    i = 0

    while i < parts.length
      if arr.hasOwnProperty(parts[i])
        arr = arr[parts[i]]
      else
        throw Error 'Schema Error: Could not get a type attributes'
      i++
    return arr


  exists : (str) ->
    arr = @types
    if typeof str isnt 'string' then return false
    parts = str.split(".")
    i = 0

    while i < parts.length
      if arr.hasOwnProperty(parts[i])
        arr = arr[parts[i]]
      else
        return false
      i++
    if typeof arr['is_parent'] is 'undefined'
      true
    else
      throw Error "Schema: cannot use a parent schema type `#{str}`"
      return false


  # *templates* take presidence, try to use chance.js if possible
  #
  types :
    Schema: ->
    Person:
      is_parent: true
      "Age" :
        min: 0
        max: 130
      "Birthday": ->
      "Gender": ->
      "Last": ->
      "First": ->
      "Name": ->
      "Prefix" : ->
    guid   : () ->
      chance.guid()
    string : () ->

    number : () ->
    object : () ->
    boolean: () ->

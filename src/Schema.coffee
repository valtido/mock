root = exports ? this

Chance = require 'chance'
utils = require '../lib/coffee-utils'
typeOf = require '../lib/typeOf'
chance = new Chance(); 

class Schema
	constructor: (config) ->
		if config
			for key, item of config
				#check if type is string, then translate it if is valid
				#e.g: new Schema({age : 'Person.Age'})
				if typeOf( item ) is "[object String]"
					if key is 'type'
						throw "Schema Error: The String of `#{key}` NEVER HERE."
					else 
						if @exists item
							type = item
							config[key] = utils.merge(@get_type(type) ,{type: type})
						else
							throw "Schema Error: The String `#{item}` of `#{key}` is not a valid Schema type."
				else if typeOf( item ) is "[object Object]"
					type = item.type
					# has type?
					if typeof type isnt 'undefined'
						# is it valid type?
						if not @exists type
							throw "Schema Error: Invalid schema type #{item} of `#{key}`"
						else
							config[key] =  utils.merge(@get_type(type), item, {type: type}) 
					else 
						config[key] = new Schema(item)
						# config[key].type = 'Schema'

				else
					throw "Schema Error: Unknown schema Type `#{item}` of `#{key}`"
		else 
			throw "Schema Error: You must provide an object"
		config.type = 'Schema'
		return config

	get_type : (str) ->
		arr = @types
		if typeof str isnt 'string' then return false;
		parts = str.split(".")
		i = 0

		while i < parts.length
			if arr.hasOwnProperty(parts[i])
				arr = arr[parts[i]]
			else
				throw 'Schema Error: Could not get a type attributes'
			i++
		return arr
	

	exists : (str) ->
		arr = @types
		if typeof str isnt 'string' then return false;
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
			throw "Schema Error: You cannot use a parent schema type `#{str}`, be more specific e.g: `Person.Age`."
			return false
	
	isEmpty: (obj) ->
		for name of obj
			return false
		true

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


module.exports = Schema
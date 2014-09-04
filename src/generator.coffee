class Generator
	constructor : (config, schema, records = 100) ->
		data = []
		for num in [0,records]
			row = @generate config, schema, records
			data.push row
		return data

	generate: (config, schema, records)->
		self = @
		data = {}
		for key, item of config
			if schema[key]?.type
				switch schema[key].type.toString().toLowerCase()
					when "schema" then data[key] = do ->
						return self.generate(item, schema[key], records)
					when "person.first" then data[key] = do ->
							return chance.first()
					when "person.last" then data[key] = do ->
							return chance.last()
					when "person.age" then data[key] = do ->
							options = 
								min: item.min
								max: item.max
							return chance.natural(options)
						
					when "number" then data[key] = chance.number()
					when "string" then data[key] = chance.string()
					else throw "there was an error, with the typeof data #{schema[item].type}"
			else
				throw "Could not generate data, #{key} is not found on the schema."
		return data

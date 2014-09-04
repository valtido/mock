describe "Generator: ", ->
	describe "Person.Age", ->
		it "Should generate a random age between 18 and 130.", ->
			userConfig = 
				age : {min: 18, max: 130}
			userSchema = new Schema
				age : 'Person.Age'
			data = new Generator userConfig, userSchema, 1
			age = data[0].age
			expect(age).not.toBeUndefined()
			expect(age).toEqual(jasmine.any(Number))
			expect(age).toBeGreaterThan userConfig.age.min 
			expect(age).toBeLessThan userConfig.age.max

	describe "Person.First", ->
		it "Should generate a random name realistic name",->
			userConfig = 
				name : 
					first: 'Person.First'
			userSchema = new Schema
				name : 
					first: 'Person.First'
			data = new Generator userConfig, userSchema, 1
			row = data[0]
			console.log(row.name)
			expect(row.name.first).toEqual(jasmine.any(String))
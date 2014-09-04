# tests should go here.

describe 'Setting up a schema', ->
	## CASE 1
	describe 'Using a String', ->																				#JSON#  { age : "Person.Age" }
		# setup
		userSchema = 
			age : "Person.Age"
		user = new Schema(userSchema)

		# assert
		it "expect string, be converted to object", ->
			expect(user.type).toBe('Schema')
			expect(user.age.type).toBe("Person.Age")

	## CASE 2
	describe 'Using an Object correctly', ->																			#JSON#	{ age : { type : "Person.Age"}
		# setup
		userSchema = 
			age : 
				type: "Person.Age"
		user = new Schema(userSchema)
		
		# assert
		it "expect object, to have type in as property.", ->
			expect(user.type).toBe('Schema')
			expect(user.age.type).toBe('Person.Age')

	## CASE 3
	describe 'Using an Object as a subclass', ->																			#JSON# { name : { first : 'Person.First' } } 
		# setup
		userSchema = 
			name: 
				first: 'Person.First'
		user = new Schema(userSchema)
		
		# assert
		it "expect object, to traverse and convert strings to type", ->
			expect(user.type).toBe('Schema')
			expect(user.name.type).toBe('Schema')
			expect(user.name.first.type).toBe('Person.First')

	## CASE 4
	describe 'Using an Object deep', ->																			#JSON# {   age : { type: "Person.Age"},			name: {first:'Person.First', last:{type:'Person.Last'}}   }
		# setup
		userSchema = 
			age : "Person.Age"
			name: 
				first: 'Person.First'
				last : 
					type: 'Person.Last'
			

		user = new Schema(userSchema)
		
		# assert
		it "expect object, mixed object to pass", ->
			expect(user.type).toBe('Schema')
			expect(user.age.type).toBe('Person.Age')
			expect(user.name.type).toBe('Schema')
			expect(user.name.first.type).toBe('Person.First')
			expect(user.name.last.type).toBe('Person.Last')

	## CASE 5
	describe 'Using an Object with other attributes', ->																			#JSON# {   age : { type: "Person.Age"},			name: {first:'Person.First', last:{type:'Person.Last'}}   }
		# setup
		userSchema = 
			age : 
				type: "Person.Age"
				min : 18
			name: 
				first: 'Person.First'
				last : 
					type: 'Person.Last'
			gender : 
				'type' : "Person.Gender"
				"default" : 'Unknown'

		user = new Schema(userSchema)
		
		# assert
		it "expect object, mixed object to pass and allow attributes to be validated", ->
			expect(user.type).toBe('Schema')
			expect(user.age.type).toBe('Person.Age')
			expect(user.age.min).toBe(18)
			expect(user.name.type).toBe('Schema')
			expect(user.name.first.type).toBe('Person.First')
			expect(user.name.last.type).toBe('Person.Last')
			expect(user.gender.type).toBe('Person.Gender')
			expect(user.gender['default']).toBe('Unknown')

		## CASE 6
	describe 'Using a parent should throw error', ->																			#JSON# {   age : { type: "Person.Age"},			name: {first:'Person.First', last:{type:'Person.Last'}}   }
		# setup
		userSchema = 
			age : "Person"

		# assert
		it "expect object, mixed object to pass and allow attributes to be validated", ->
			expect( -> new Schema(userSchema) ).toThrow("Schema Error: You cannot use a parent schema type `Person`, be more specific e.g: `Person.Age`.")

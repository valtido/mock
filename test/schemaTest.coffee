# tests should go here.
chai = require 'chai'
Schema = require '../lib/Schema'
expect = chai.expect;

describe 'Setting up a schema', ->
	## CASE 1
	describe 'Using a String', ->																				#JSON#  { age : "Person.Age" }
		# setup
		userSchema = 
			age : "Person.Age"
		user = new Schema(userSchema)

		# assert
		it "expect string, be converted to object", ->
			expect(user.type).to.eql('Schema')
			expect(user.age.type).to.eql("Person.Age")

	## CASE 2
	describe 'Using an Object correctly', ->																			#JSON#	{ age : { type : "Person.Age"}
		# setup
		userSchema = 
			age : 
				type: "Person.Age"
		user = new Schema(userSchema)
		
		# assert
		it "expect object, to have type in as property.", ->
			expect(user.type).to.eql('Schema')
			expect(user.age.type).to.eql('Person.Age')

	## CASE 3
	describe 'Using an Object as a subclass', ->																			#JSON# { name : { first : 'Person.First' } } 
		# setup
		userSchema = 
			name: 
				first: 'Person.First'
		user = new Schema(userSchema)
		
		# assert
		it "expect object, to traverse and convert strings to type", ->
			expect(user.type).to.eql('Schema')
			expect(user.name.type).to.eql('Schema')
			expect(user.name.first.type).to.eql('Person.First')

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
			expect(user.type).to.eql('Schema')
			expect(user.age.type).to.eql('Person.Age')
			expect(user.name.type).to.eql('Schema')
			expect(user.name.first.type).to.eql('Person.First')
			expect(user.name.last.type).to.eql('Person.Last')

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
			expect(user.type).to.eql('Schema')
			expect(user.age.type).to.eql('Person.Age')
			expect(user.age.min).to.eql(18)
			expect(user.name.type).to.eql('Schema')
			expect(user.name.first.type).to.eql('Person.First')
			expect(user.name.last.type).to.eql('Person.Last')
			expect(user.gender.type).to.eql('Person.Gender')
			expect(user.gender['default']).to.eql('Unknown')

		## CASE 6
	describe 'Using a parent should throw error', ->																			#JSON# {   age : { type: "Person.Age"},			name: {first:'Person.First', last:{type:'Person.Last'}}   }
		# setup
		userSchema = 
			age : "Person"

		# assert
		it "expect object, mixed object to pass and allow attributes to be validated", ->
			expect( -> new Schema(userSchema) ).to.throw("Schema Error: You cannot use a parent schema type `Person`, be more specific e.g: `Person.Age`.")

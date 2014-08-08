# Cakefile

{exec} = require "child_process"

log  = console.log
error = console.error


REPORTER = "list"

task "test", "run tests", ->
  exec "SET NODE_ENV=test
    ./node_modules/.bin/mocha
    --require coffee-script/register
    --compilers coffee:coffee-script/register
    --bare
    --reporter #{REPORTER}
    --recursive ./test
    --require test/test_helper.coffee
    --colors
    ", (err, output) ->
      throw err if err
      log output
		

task 'build', 'Build project from src/*.coffee to lib/*.js', ->
	exec 'coffee -b --compile --output lib/ src/', (err, stdout, stderr) ->
		throw err if err
		log stdout + stderr


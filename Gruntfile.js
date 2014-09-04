/**
 * Created by vcaushi on 19/08/2014.
 */

module.exports = function(grunt){
	//project configuration
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		karma:
		{
			unit:
			{
				configFile: 'karma.conf.js'
			}
		}
	});

	grunt.loadNpmTasks("grunt-karma");

	grunt.registerTask("default",["karma"]);
};
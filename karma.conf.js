// Karma configuration
// Generated on Tue Aug 19 2014 10:58:18 GMT+0100 (GMT Daylight Time)

module.exports = function(config) {
	config.set({

		// base path that will be used to resolve all patterns (eg. files, exclude)
		basePath: '',


		// frameworks to use
		// available frameworks: https://npmjs.org/browse/keyword/karma-adapter
		frameworks: ['jasmine'],


		// list of files / patterns to load in the browser
		files: [
			{pattern: 'bower_components/jquery/dist/jquery.min.map', included: false},
			{pattern: 'bower_components/jquery/dist/jquery.min.js', included: true},
			{pattern: 'bower_components/chance/chance.js', included: true},
			{pattern: 'src/**/*.coffee', included: true},
			{pattern: 'src/**/*.js', included: true},
			{pattern: 'test/**/*.coffee', included: true},
			{pattern: 'test/**/*.js', included: true}
		],


		// list of files to exclude
		exclude: [
		],


		// preprocess matching files before serving them to the browser
		// available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
		preprocessors: {
			// source files, that you wanna generate coverage for
			// do not include tests or libraries
			// (these files will be instrumented by Istanbul via Ibrik unless
			// specified otherwise in coverageReporter.instrumenter)
			'src/**/*.coffee': ['coffee'],

			// note: project files will already be converted to
			// JavaScript via coverage preprocessor.
			// Thus, you'll have to limit the CoffeeScript preprocessor
			// to uncovered files.
			'test/**/*.coffee': ['coffee']
		},

		coffeePreprocessor: {
			// options passed to the coffee compiler
			options: {
			 bare: true,
			 sourceMap: true
			},
			// transforming the filenames
			transformPath: function(path) {
			 return path.replace(/\.coffee$/, '.js');
			}
		},


		// test results reporter to use
		// possible values: 'dots', 'progress'
		// available reporters: https://npmjs.org/browse/keyword/karma-reporter
		reporters: ['progress', 'coverage'],

		// optionally, configure the reporter
		coverageReporter: {
			type : 'html',
			dir : 'coverage/'
		},
		// web server port
		port: 9876,


		// enable / disable colors in the output (reporters and logs)
		colors: true,


		// level of logging
		// possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
		logLevel: config.LOG_INFO,


		// enable / disable watching file and executing tests whenever any file changes
		autoWatch: true,


		// start these browsers
		// available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
		browsers: ['chrome_without_security' /* * /'firefox_without_security', 'Safari','Firefox', /* */],

			customLaunchers : {
			 chrome_without_security: {
				 base: "Chrome",
				 flags : "--disable-web-security"
			 },
			 firefox_without_security: {
				 base: "Chrome",
				 flags : "--disable-web-security"
			 }
			},

		captureTimeout: 60000,
		// Continuous Integration mode
		// if true, Karma captures browsers, runs the tests and exits
		singleRun: false
	});
};

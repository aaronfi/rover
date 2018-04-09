var path = require('path');
var webpack = require('webpack');
var ClosureCompilerPlugin = require('webpack-closure-compiler');

var closureCompiler = new ClosureCompilerPlugin();
closureCompiler.options['language_in'] = 'ECMASCRIPT6_STRICT';  // override the plugin's hard-coded default value of 'ES5';
closureCompiler.options['compilation_level'] = 'SIMPLE';   // 2015.09.01 the 'ADVANCED' setting was causing my unit tests to break
// closureCompiler.options['language_out'] = 'ES5';  // the default setting is 'ES5'

module.exports = {
    context: __dirname,
    entry: {
        gobble: './bundle.js'
    },
    output: {
        path: path.join(__dirname, '../', 'app', 'assets', 'javascripts', 'generated'),
        filename: "[name]-bundle.js"
    },

    // TODO do I really need to be piping my builds through Babel (the es6->es5 transpiler) and then Closure Compiler, and then UglifyJS?
    module: {
        loaders: [
            {
                test: /\.js$/,
                loaders: ['babel'],
                exclude: '/node_modules/'
            }
        ]
    },
    // plugins: [
    //     closureCompiler,
    //     new webpack.optimize.UglifyJsPlugin({  // TODO what version number of UglifyJs does the webpack module have?  It isn't clear.
    //         sourceMap: false   // 2015.09.01 needed to avoid a build error:  "Cannot read property 'sections' of null"  

    //         // TODO look into version 2 of this module https://github.com/mishoo/UglifyJS2
    //         // TODO look into its -mangle and -compress options
    //     })
    // ],
};


/* 
var Mocha = require('mocha'),
    fs = require('fs'),
    path = require('path');

var mocha = new Mocha({
    timeout: 16000,
    ui: 'tdd'
});

mocha.addFile('./main-bundle.js');

mocha.run(function(failures){
    process.on('exit', function () {
        process.exit(failures);
    });
});

*/ 
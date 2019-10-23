// Custom Grunt tasks
// Chris Joakim, Microsoft, 2019/10/08

var fs = require('fs');

module.exports = function(grunt) {

  grunt.registerTask('build-timestamp', 'Create the build_timestamp.json file', function() {
    var outfile = 'build_timestamp.json';
    var now = new Date();
    var ts = new Date().toString();
    var obj = {};
    obj['build_user'] = process.env.USER || 'unknown';
    obj['build_timestamp'] = now.toUTCString();
    obj['build_epoch'] = now.getTime();
    var jstr = JSON.stringify(obj, null, 2);

    var js_file = fs.openSync(outfile, 'w+');
    fs.writeSync(js_file, jstr);
    fs.closeSync(js_file);

    grunt.log.writeln(outfile + "\n" + jstr);
  });

};

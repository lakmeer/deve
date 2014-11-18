
// Require

var gulp       = require('gulp'),
    gutil      = require('gulp-util'),
    browserify = require('browserify'),
    nodemon    = require('gulp-nodemon'),
    source     = require('vinyl-source-stream'),
    connect    = require('gulp-connect')
    lr         = require('gulp-livereload');


// Helpers

function reload (files) {
  gulp.src(files.path).pipe(connect.reload());
}

function handle (error) {
  gutil.log(error.message ? error.message : error);
  this.emit('end');
}


// Preconfigure bundler

var bundler = browserify({
  debug: true,
  cache: {},
  packageCache: {},
  extensions: '.ls',
  entries: [ './client/index.ls' ]
});


// Tasks

gulp.task('server', function () {
  nodemon({
    script: 'server/index.ls',
    ext: 'html js css ls',
    execMap: { "ls" : "lsc" },
    ignore: [ 'public/*', 'client/*' ]
  });
});

gulp.task('browserify', function () {
  return bundler
    .bundle()
    .on('error', handle)
    .pipe(source('app.js'))
    .pipe(gulp.dest('public'))
});


// Register

gulp.task('default', [ 'server', 'browserify' ], function () {
  lr.listen();
  gulp.watch(['client/**/*.ls'], [ 'browserify' ]);
  gulp.watch(['public/**/*']).on('change', lr.changed);
});



// Require

var gulp       = require('gulp'),
    gutil      = require('gulp-util'),
    browserify = require('browserify'),
    nodemon    = require('gulp-nodemon'),
    source     = require('vinyl-source-stream'),
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
  entries: [ './src/index.ls' ],
  extensions: '.ls'
});


// Tasks

gulp.task('server', function () {
  nodemon({ script: 'app/index.ls', ext: 'html js css ls', execMap: { "ls" : "lsc" } })
    .on('change',  function () {})
    .on('restart', function () {});
});

gulp.task('browserify', function () {
  return bundler
    .bundle()
    .on('error', handle)
    .pipe(source('app.js'))
    .pipe(gulp.dest('client'))
});


// Register

gulp.task('default', [ 'server', 'browserify' ], function () {
  lr.listen();
  gulp.watch(['src/**/*.ls'], [ 'browserify' ]);
  gulp.watch(['client/**/*']).on('change', lr.changed);
});


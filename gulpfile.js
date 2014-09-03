var gulp = require('gulp');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var imagemin = require('gulp-imagemin');
var sourcemaps = require('gulp-sourcemaps');
var del = require('del');
var sass = require('gulp-ruby-sass');
var rimraf = require('rimraf');
var clean = require('gulp-clean');
var plumber = require('gulp-plumber');


var paths = {
    scripts: ['src/javascripts/**/*.coffee'],
    vendorScripts: ['src/javascripts/vendor/**/*.js'],
    styles: ['src/css/**/*.scss'],
    fonts: ['src/fonts/*'],
    images: 'src/images/**/*',
    html: 'src/html/**/*.html'
};

var dest = {
    root: 'public',
    css: 'public/css',
    js: 'public/js',
    fonts: 'public/fonts',
    imgs: 'public/img'
};

// Not all tasks need to use streams
// A gulpfile is just another node program and you can use all packages available on npm
gulp.task('clean', function(cb) {
    // You can use multiple globbing patterns as you would with `gulp.src`
    rimraf(dest.root, cb);
//    gulp.src([dest.root], {read: false})
//        .pipe(clean());
});

gulp.task('scripts', function() {
    // Minify and copy all JavaScript (except vendor scripts)
    // with sourcemaps all the way down
    return gulp.src(paths.scripts)
        .pipe(sourcemaps.init())
        .pipe(plumber())
        .pipe(coffee({bare: true}))
        .pipe(uglify())
        .pipe(concat('all.min.js'))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(dest.js));
});


gulp.task('vendorScripts', function() {
    return gulp.src(paths.vendorScripts)
        .pipe(gulp.dest(dest.js));
});

// Copy all static images
gulp.task('images', function() {
    return gulp.src(paths.images)
        // Pass in options to the task
//        .pipe(imagemin({optimizationLevel: 5}))
        .pipe(gulp.dest(dest.imgs));
});

gulp.task('sass',  function() {
    return gulp.src(paths.styles)
        .pipe(sass())
        .on('error', function (err) { console.log(err.message); })
        .pipe(gulp.dest(dest.css));
});

gulp.task('fonts', function(){
    return gulp.src(paths.fonts)
        .pipe(gulp.dest(dest.fonts));
});

gulp.task('html', function(){
   return gulp.src(paths.html)
       .pipe(gulp.dest(dest.root));
});

// Rerun the task when a file changes
gulp.task('watch', function() {
    gulp.watch(paths.scripts, ['scripts']);
    gulp.watch(paths.vendorScripts, ['vendorScripts']);
    gulp.watch(paths.images, ['images']);
    gulp.watch(paths.styles, ['sass']);
    gulp.watch(paths.fonts, ['fonts']);
    gulp.watch(paths.html, ['html']);
});

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['clean'], function(){
    gulp.start(['watch','vendorScripts', 'scripts', 'images', 'fonts', 'sass', 'html']);
});
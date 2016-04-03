gulp = require('gulp')
coffee = require('gulp-coffee')
stylus = require('gulp-stylus')
gutil = require('gulp-util')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
minify = require('gulp-clean-css')
sourcemaps = require('gulp-sourcemaps')
autoprefixer = require('gulp-autoprefixer')


# Paths to source and dest foldes
paths =
# Source Folders
  coffeescript: './sources/coffeescript/*.coffee'
  stylus: './sources/stylus/*.styl'

# Destination Folders
  coffeescript_dest: './js/'
  stylus_dest: './css/'

# Concat Files
  coffeescript_concat: 'app.min.js'
  stylus_concat: 'main.min.css'

# Compile CoffeeScript
gulp.task 'coffeescript', ->
  gulp.src(paths.coffeescript)
  .pipe(sourcemaps.init())
    .pipe(coffee(bare: true).on('error', gutil.log))
    .pipe(uglify())
    .pipe(concat(paths.coffeescript_concat))
  .pipe(sourcemaps.write())
  .pipe gulp.dest(paths.coffeescript_dest)
  return

# Compile Stylus
gulp.task 'stylus', ->
  gulp.src(paths.stylus)
  .pipe(sourcemaps.init())
    .pipe(stylus())
    .pipe(autoprefixer())
    .pipe(minify({compatibility: 'ie8'}))
    .pipe(concat(paths.stylus_concat))
  .pipe(sourcemaps.write())
  .pipe gulp.dest(paths.stylus_dest)
  return

# Default Tast, Run this
gulp.task 'default', [
  'coffeescript'
  'stylus'
]
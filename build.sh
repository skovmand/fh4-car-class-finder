#!/bin/bash
set -e

echo "Building car classes."
echo ""
echo "removing existing build folder ------>"
rm -rv ./dist
mkdir ./dist

JS_UNMINIFIED="main.js"
JS_MINIFIED="main.min.js"

echo ""
echo "elm make -------->"
pushd elm > /dev/null
elm make src/Main.elm --output ../dist/$JS_UNMINIFIED --optimize
popd > /dev/null

echo ""
echo "optimize elm build -------->"
pushd uglify > /dev/null
./node_modules/.bin/uglifyjs ../dist/$JS_UNMINIFIED --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle > ../dist/$JS_MINIFIED
popd > /dev/null

echo ""
echo "tailwind -------->"
pushd tailwind > /dev/null
NODE_ENV=production ./node_modules/.bin/postcss src/styles.css -o ../dist/styles.css
popd > /dev/null

echo ""
echo "html ------------>"
cp html/index.html dist/index.html

echo "done!"
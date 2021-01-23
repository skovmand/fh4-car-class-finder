#!/bin/bash
set -e

echo "Building car classes."
echo ""
echo "removing existing build folder ------>"
rm -rv ./dist
mkdir ./dist

echo ""
echo "elm make -------->"
pushd elm > /dev/null
elm make src/Main.elm --output ../dist/main.js --optimize
popd > /dev/null

echo ""
echo "tailwind -------->"
pushd tailwind > /dev/null
./node_modules/.bin/postcss src/styles.css -o ../dist/styles.css
popd > /dev/null

echo ""
echo "html ------------>"
cp html/index.html dist/index.html

echo "done!"

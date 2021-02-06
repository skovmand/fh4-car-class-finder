# Forza Horizon 4 Car Class Finder

A programming project for August (8 years old) and me to find car classes in our favourite game Forza Horizon 4. Visit the webpage live at https://skovmand.github.io/fh4-car-class-finder/


## Install dependencies

Make sure [Elm 0.19.1](https://guide.elm-lang.org/install/elm.html) is installed globally. Then install the javascript dependencies:

```
# Install uglify (in a separate folder, just used to minimize the js build)
cd uglifyjs
npm ci
cd ..

# Install tailwindcss and deps
cd tailwind
npm ci
cd ..
```

## Building the project

```
# Make a development build in build/dev
make clean dev

# Make a production build in build/prod
make clean prod
```

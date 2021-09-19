build/dev:
	mkdir -p build/dev

build/prod:
	mkdir -p build/prod

# Development build -->
build/dev/index.html: html/index.html
	cp $^ $@

build/dev/main.js: elm/src/Main.elm
	cd elm; elm make src/Main.elm --output "../$@"

build/dev/styles.css: tailwind/src/styles.css tailwind/tailwind.config.js
	cd tailwind; ./node_modules/.bin/postcss src/styles.css -o "../$@"

build/dev/img: $(shell find img -type f)
	mkdir -p build/dev/img; cp "$^" "$@/"

# Production build -->
build/prod/index.html: html/index.html
	sed -e "s/main\.js/main\.min\.js/" -e "s/styles\.css/styles\.min\.css/" $^ > $@

build/prod/main.js: elm/src/Main.elm
	cd elm; elm make src/Main.elm --output "../$@" --optimize

build/prod/main.min.js: build/prod/main.js
	cd uglify;\
	./node_modules/.bin/uglifyjs "../$^" --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | ./node_modules/.bin/uglifyjs --mangle > "../$@";\
	rm -v "../$^"

build/prod/styles.min.css: tailwind/src/styles.css elm/src/Main.elm html/index.html tailwind/tailwind.config.js
	cd tailwind; NODE_ENV=production ./node_modules/.bin/postcss src/styles.css -o "../$@"

build/prod/img: $(shell find img -type f)
	mkdir -p build/prod/img; cp "$^" "$@/"

clean:
	rm -rf build

dev: build/dev build/dev/index.html build/dev/img build/dev/main.js build/dev/styles.css
prod: build/prod build/prod/index.html build/prod/img build/prod/main.min.js build/prod/styles.min.css

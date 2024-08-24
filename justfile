build-elm: create-build-directory install-dependencies
  elm make source/Main.elm --optimize --output=build/main.js
  npx uglifyjs build/main.js \
    --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' \
    | npx uglifyjs --mangle --output build/main.min.js


build-website: build-elm copy-static-assets
alias build := build-website

copy-static-assets: create-build-directory
  cp -R static/* build

# --- #

create-build-directory:
  mkdir -p build

install-dependencies:
  npm install

run-development-server: create-build-directory copy-static-assets install-dependencies
  npx elm-live source/Main.elm \
    --dir build \
    --start-page=build/index.html \
    -- --output=build/main.js --debug
alias dev := run-development-server

test: build-website
  npx elm-test

# --- #

format: install-dependencies
  npx prettier . --write

format-check: install-dependencies
  npx prettier . --check

# --- #

clear-build-directory:
  rm -rf build
alias clear := clear-build-directory

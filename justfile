build-elm: create-build-directory
  elm make source/Main.elm --optimize --output=build/main.js

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

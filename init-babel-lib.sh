#!/bin/sh

# install babel-cli
echo installing babel-cli
npm install --save-dev babel-cli

# setup folders
echo setting up folders
mkdir -p src # where source code lives
mkdir -p lib # where output lives

echo setting up package.json
json -I -f package.json -e 'this.scripts.build="babel --out-lib lib src --copy-files"'
json -I -f package.json -e 'this.scripts.watch="babel --out-lib lib src --copy-files --watch"'
json -I -f package.json -e 'this.main="lib/index.js"'

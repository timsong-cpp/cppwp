#! /bin/sh

# Build the networking TS
cd networking-ts/src
git reset --hard origin/master
latexmk -pdf ts
git apply ../../networking_htmlgen.patch
cd ../../cxxdraft-htmlgen-networking
cabal build
dist/build/cxxdraft-htmlgen/cxxdraft-htmlgen ../networking-ts Bare
cd 14882
rm -r ../../gh-pages/networking-ts/*
mv 14882.css index.html math ../../gh-pages/networking-ts/
find . -type f -exec mv '{}' '../../gh-pages/networking-ts/{}.html' \;
cd ..
rmdir 14882

cd ../gh-pages
cp ../networking-ts/src/ts.pdf ./networking-ts.pdf

cd ..

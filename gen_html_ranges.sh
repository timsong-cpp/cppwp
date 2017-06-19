#! /bin/sh

# Build the networking TS
cd ranges-ts
git reset --hard origin/master
latexmk -pdf ranges
git apply ../ranges_htmlgen.patch

cd ../cxxdraft-htmlgen-ranges
cabal build
dist/build/cxxdraft-htmlgen/cxxdraft-htmlgen ../ranges-ts Bare
cd 14882
rm -r ../../gh-pages/ranges-ts/*
mv 14882.css index.html math ../../gh-pages/ranges-ts/
find . -type f -exec mv '{}' '../../gh-pages/ranges-ts/{}.html' \;
cd ..
rmdir 14882

cd ../gh-pages
cp ../ranges-ts/ranges.pdf ./ranges-ts.pdf

cd ..

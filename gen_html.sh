#! /bin/sh

git submodule foreach git pull origin

# Build the standard
cd draft/source
git reset --hard origin/master

if [ -f ../../all.patch ]
then
git apply ../../all.patch
fi
latexmk -pdf std

if [ -f ../../htmlgen.patch ]
then
git apply ../../htmlgen.patch
fi

cd ../../cxxdraft-htmlgen
git reset --hard origin/master
if [ -f ../htmlgen_code.patch ]
then
git apply ../htmlgen_code.patch
fi
rm -rf 14882
runhaskell genhtml.hs ../draft Bare

rm ../gh-pages/*.html ../gh-pages/draft.pdf
find 14882/ -maxdepth 1 -type f -execdir cp '{}' ../../gh-pages/'{}'.html \;
rm -r 14882

# Build the networking TS
cd ../networking-ts/src
latexmk -pdf ts

# Build the ranges TS
cd ../../ranges-ts
latexmk -pdf ranges

# Fixup gh-pages
cd ../gh-pages
mv 14882.css.html 14882.css
mv index.html.html index.html
mv icon.png.html icon.png
cp ../draft/source/std.pdf ./draft.pdf
cp ../networking-ts/src/ts.pdf ./networking-ts.pdf
cp ../ranges-ts/ranges.pdf ./ranges-ts.pdf

git add -A
git commit -m 'Update'

if [ "$1" != "nopush" ]
then
git push
fi

cd ..
if [ "$1" != "nopush" ]
then
git commit -am 'Update'
git push
fi

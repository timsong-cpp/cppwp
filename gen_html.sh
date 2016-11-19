#! /bin/sh

git submodule foreach git pull origin

# Build the standard
cd draft/source
latexmk -pdf std

cd ../../cxxdraft-htmlgen
rm -rf 14882
runhaskell genhtml.hs ../draft Bare

rm -r ../gh-pages/math
rm ../gh-pages/*.html ../gh-pages/draft.pdf
cp -r 14882/math ../gh-pages/
find 14882/ -maxdepth 1 -type f -execdir cp '{}' ../../gh-pages/'{}'.html \;
rm -r 14882

# Build the networking TS
cd ../networking-ts/src
latexmk -pdf ts

# Fixup gh-pages
cd ../../gh-pages
mv 14882.css.html 14882.css
mv index.html.html index.html
cp ../draft/source/std.pdf ./draft.pdf
cp ../networking-ts/src/ts.pdf ./networking-ts.pdf
git add -A
git commit -m 'Update'
git push

cd ..
git commit -am 'Update'
git push


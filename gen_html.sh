#! /bin/sh

git submodule foreach git pull origin

cd draft/source
latexmk -pdf std

cd ../../cxxdraft-htmlgen
rm -rf 14882
runhaskell genhtml.hs ../draft Bare

rm -r ../gh-pages/*
cp -r 14882/math ../gh-pages/
find 14882/ -maxdepth 1 -type f -execdir cp '{}' ../../gh-pages/'{}'.html \;
rm -r 14882

cd ../gh-pages
mv 14882.css.html 14882.css
mv index.html.html index.html
git add -A
git commit -m 'Update'
#git push

cd ..
git commit -am 'Update'
git push


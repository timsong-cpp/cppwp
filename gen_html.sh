#! /bin/sh

git submodule foreach git pull origin

cd draft/source
latexmk -pdf std

cd ../../cxxdraft-htmlgen
runhaskell genhtml.hs ../draft Bare

rm -r ../gh-pages/*
cp -r 14882/math ../gh-pages/
cd 14882
find * -maxdepth 0 -type f -exec cp '{}' ../../gh-pages/'{}'.html \;
rm -r 14882

cd ../gh-pages
git add -A
git commit -m 'Update'
#git push

cd ..
git commit -am 'Update'
git push


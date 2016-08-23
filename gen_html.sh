#! /bin/sh

git submodule foreach git pull origin

cd draft/source
latexmk -pdf std

cd ../../cxxdraft-htmlgen
runhaskell genhtml.hs ../draft

rm -r ../gh-pages/*
cp -r 14882/* ../gh-pages/
rm -r 14882

cd ../gh-pages
git add -A
git commit -m 'Update'
git push

cd ..
git commit -am 'Update'
git push


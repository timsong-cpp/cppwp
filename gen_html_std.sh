#! /bin/sh

# check if we need to rebuild
cd cxxdraft-htmlgen

echo "htmlgen $(git rev-parse HEAD)" > ../thisbuild.tmp

cd ../draft

echo "draft $(git rev-parse HEAD)" >> ../thisbuild.tmp

cd ..

if [ -f all.patch ]
then
sha1sum all.patch >> thisbuild.tmp
fi

if [ -f htmlgen.patch ]
then
sha1sum htmlgen.patch >> thisbuild.tmp
fi

if [ -f htmlgen_code.patch ]
then
sha1sum htmlgen_code.patch >> thisbuild.tmp
fi


if [ -f lastbuild.sig ]
then
    cmp --silent lastbuild.sig thisbuild.tmp && rm thisbuild.tmp && exit 0
fi

# Build the standard
cd draft/source
git reset --hard origin/master

if [ -f ../../all.patch ]
then
git apply ../../all.patch
fi

latexmk -c
latexmk -pdf std

cp std.pdf std_orig.pdf

if [ -f ../../htmlgen.patch ]
then
git apply ../../htmlgen.patch
fi

latexmk -c
latexmk -pdf std

# Build the HTML
cd ../../cxxdraft-htmlgen

git reset --hard origin/master
if [ -f ../htmlgen_code.patch ]
then
git apply ../htmlgen_code.patch
fi

rm -rf 14882
cabal update
cabal build
dist/build/cxxdraft-htmlgen/cxxdraft-htmlgen ../draft Bare

rm ../gh-pages/*.html ../gh-pages/draft.pdf
find 14882/ -maxdepth 1 -type f -execdir cp '{}' ../../gh-pages/'{}'.html \;
rm -r 14882

# Fixup gh-pages
cd ../gh-pages
rm *.css *.png
rename 's/.html//' *.css.html *.png.html
mv index.html.html index.html
cp ../draft/source/std_orig.pdf ./draft.pdf

cd ..

if [ -f gh-pages/full.html ]
then
mv thisbuild.tmp lastbuild.sig
else
rm thisbuild.tmp
fi


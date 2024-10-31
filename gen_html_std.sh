#! /bin/sh -e

# check if we need to rebuild
cd cxxdraft-htmlgen

echo "htmlgen $(git rev-parse HEAD)" > ../thisbuild.tmp

cd ../draft

echo "draft $(git rev-parse origin/main)" >> ../thisbuild.tmp

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
git reset --hard origin/main

if [ -f ../../all.patch ]
then
git apply ../../all.patch
fi

latexmk -pdf std

cp std.pdf std_orig.pdf

# create the "annex-f" file that maps stable names to section numbers
  grep '^\\newlabel{' *.aux \
| grep -v '\\newlabel{\(fig\|tab\):' \
| sed 's/^.*\.aux://' \
| sed 's/^\\newlabel{\([^}]*\)}{{\([^}]*\)}.*/\1 \2/' \
| grep -v '^\\' \
| sed 's/\(Clause\|Annex\) //' \
| sort > annex-f

if [ -f ../../htmlgen.patch ]
then
git apply -3 ../../htmlgen.patch
fi

# Build the HTML
cd ../../cxxdraft-htmlgen

git reset --hard origin/master
if [ -f ../htmlgen_code.patch ]
then
git apply ../htmlgen_code.patch
fi

# For WSL, need to bump the limit of open files
mylimit=9000
sudo prlimit --nofile=$mylimit --pid $$; ulimit -n $mylimit

rm -rf 14882
cabal v2-update
cabal v2-build
cabal v2-run cxxdraft-htmlgen ../draft Bare

rm -f ../gh-pages/*.html ../gh-pages/draft.pdf ../gh-pages/annex-f
find 14882/ -maxdepth 1 -type f -execdir cp '{}' ../../gh-pages/'{}'.html \;
rm -r 14882

# Fixup gh-pages
cd ../gh-pages
rm -f *.css *.png
rename 's/.html//' *.css.html *.png.html
mv index.html.html index.html
cp ../draft/source/std_orig.pdf ./draft.pdf
cp ../draft/source/annex-f ./

cd ..

if [ -f gh-pages/full.html ]
then
mv thisbuild.tmp lastbuild.sig
else
rm thisbuild.tmp
fi


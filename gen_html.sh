#! /bin/sh -e

git submodule foreach 'git pull origin || :'

./gen_html_std.sh
#./gen_html_networking.sh
#./gen_html_ranges.sh

if [ ! -f gh-pages/intro.html ] ||  [ ! -f gh-pages/ranges-ts/intro.html ] || [ ! -f gh-pages/networking-ts/scope.html ]
then
echo "Something was wrong."
exit 1
fi

cd gh-pages
git add -A
git commit -m 'Update'

if [ "$1" != "nopush" ]
then
git push
fi

cd ..
if [ "$1" != "nopush" ]
then
git add *.patch
git commit -am 'Update'
git push
fi

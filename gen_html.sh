#! /bin/sh

git submodule foreach 'git pull origin || :'

./gen_html_std.sh
./gen_html_networking.sh
./gen_html_ranges.sh

if [ ! -f gh-pages/full.html ] ||  [ ! -f gh-pages/ranges-ts/full.html ] || [ ! -f gh-pages/networking-ts/full.html ]
then
echo "Something was wrong."
exit 1
fi

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

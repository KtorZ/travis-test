#!/bin/sh

touch test
git config --local user.name "Travis"
git config --local user.email "matthias.benkort+travis@gmail.com"
git checkout -b "release-x.x.x"
git add test
git commit -m "Patate"
git push origin release-x.x.x

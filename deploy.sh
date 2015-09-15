#!/bin/sh

git checkout -b "release-x.x.x"
git add tiapp.xml
git commit -m "Patate"
git remote -vv
git status

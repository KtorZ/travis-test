#!/bin/sh

touch test
git checkout -b "release-x.x.x"
git add test
git commit -m "Patate"
git push origin release-x.x.x

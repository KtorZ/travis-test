#!/bin/sh

GH_REPO=$(basename `git rev-parse --show-toplevel`)

touch test

git remote add deploy https://$GH_USER:${GH_TOKEN}@github.com/$GH_USER/$GH_REPO.git
git checkout -b "release-x.x.x"
git add test
git commit -m "Patate"
git push deploy release-x.x.x

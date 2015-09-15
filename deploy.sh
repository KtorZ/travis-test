#!/bin/sh

GH_REPO=$(basename `git rev-parse --show-toplevel`)

PATCH=$(git log --oneline | grep -c "\[ *patch *\]")
MINOR=$(git log --oneline | grep -c "\[ *minor *\]")
MAJOR=$(git log --oneline | grep -c "\[ *major *\]")

echo "$MAJOR.$MINOR.$PATCH"

touch test

git remote add deploy https://$GH_USER:${GH_TOKEN}@github.com/$GH_USER/$GH_REPO.git
git checkout -b "release-x.x.x"
git add test
git commit -m "Patate"
git push deploy release-x.x.x > ignore

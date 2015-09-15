#!/bin/sh

GH_REPO=$(basename `git rev-parse --show-toplevel`)

PATCH=$(git log --oneline | grep -c "\[ *patch *\]")
MINOR=$(git log --oneline | grep -c "\[ *minor *\]")
MAJOR=$(git log --oneline | grep -c "\[ *major *\]")
VERSION="$MAJOR.$MINOR.$PATCH"

echo $VERSION > test

# Set up a bit of configuration
git config --local user.name $GH_USER
git config --local user.username $GH_USER
git remote add deploy https://$GH_USER:${GH_TOKEN}@github.com/$GH_USER/$GH_REPO.git

# Do the release commit
git checkout -b "release-$VERSION"
git add test
git commit -m "Patate"

# Silent push to avoid the token to be shown in the console ^.^
touch ___ignore
git push deploy release-$VERSION <___ignore >___ignore 2>___ignore
rm -rf ___ignore

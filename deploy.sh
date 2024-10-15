#!/bin/bash
# check for uncommitted changes. if detected, exit script
echo "Checking for uncommitted changes..."
if [[ -n "$(git status -s)" ]]; then
    echo "You have uncommitted changes, please commit or stash them!"
    exit 1
fi
echo "No uncommited changes!"
# switch to main, pull from origin, build website to _site
git switch main
git pull origin main
echo "Building website to _site.."
bundle exec jekyll build

# switch to gh-pages
git switch gh-pages
# delete everything except _site
echo "Removing all files except _site.."
git rm -rf .
# movie files in _site to root, remove _site
echo "Exploding contents of _site to root.."
mv _site/* .
rm -rf _site

# commit and push to gh-pages
echo "Staging and committing to local gh-pages branch.."
git add .
git commit -m "Deploy site at $(date +%Y-%m-%d)"
echo "Pushing website to remote (gh-pages).."
git push origin gh-pages

# switch back to main
git switch main
echo "Pushing Jekyll structure to remote (main).."
git push origin main

echo "Deployment complete!"


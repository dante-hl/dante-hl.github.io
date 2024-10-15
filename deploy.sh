#!/bin/bash
# check for uncommitted changes. if detected, exit script
if [[ -z "$(git status -s) "]]; then
    echo "You have uncommitted changes, please commit or stash them!"
    exit 1
fi
# switch to main, pull from origin, build website to _site
git switch main
git pull origin main
bundle exec jekyll build

# switch to gh-pages
git switch gh-pages
# delete everything except _sites
git rm -rf .
# movie files in _site to root, remove _site
mv _site/* .
rm -rf _site

# commit and push to gh-pages
git add .
git commit -m "Deploy site at $(date +%Y-%m-%d)"
git push origin gh-pages

# switch back to main
git switch main


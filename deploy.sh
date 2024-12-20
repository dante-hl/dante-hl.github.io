#!/bin/bash

# this deploy script builds the website (creating the _site directory) in main. _site is gitignored. it then switches to gh-pages, deletes everything except _site, moves the contents of _site to the root (and deletes _site), then stages, commits, and pushes to gh-pages remotely. 

# check for uncommitted changes. if detected, exit script
echo -e "Checking for uncommitted changes..."
if [[ -n "$(git status -s)" ]]; then
    echo -e "You have uncommitted changes, please commit or stash them!"
    exit 1
fi
echo -e "No uncommitted changes! Switching to main and pulling from remote..\n"
# switch to main, pull from origin, build website to _site
git switch main
git pull origin main
echo -e "\nBuilding website to _site..\n"
bundle exec jekyll build

# Check if _site directory actually gets created (branch will always start without a _site dir)
if [[ ! -d "_site" ]]; then
    echo "Error: _site directory was not created. Jekyll build failed"
    exit 1
fi

# switch to gh-pages
git switch gh-pages
# delete everything except _site
echo -e "\nRemoving all files except _site..\n"
git rm -rf .
# move files in _site to root, remove _site
echo -e "\nExploding contents of _site to root.."
mv _site/* .
rm -rf _site

# commit and push to gh-pages
echo -e "Staging and committing to local gh-pages branch..\n"
git add .
git commit -m "Deploy site at $(date "+%Y-%m-%d %H:%M:%S")"
echo -e "\nPushing website to remote (gh-pages)..\n"
git push origin gh-pages

# switch back to main
git switch main
echo -e "\nPushing Jekyll structure to remote (main)..\n"
git push origin main

echo -e "Deployment complete!"


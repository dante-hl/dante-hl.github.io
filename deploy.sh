#!/bin/bash
# check for uncommitted changes. if detected, exit script
echo -e "Checking for uncommitted changes...\n"
if [[ -n "$(git status -s)" ]]; then
    echo -e "You have uncommitted changes, please commit or stash them!"
    exit 1
fi
echo -e "\nNo uncommitted changes!\n"
# switch to main, pull from origin, build website to _site
git switch main
git pull origin main
echo -e "\nBuilding website to _site..\n"
bundle exec jekyll build

# switch to gh-pages
git switch gh-pages
# delete everything except _site
echo -e "\nRemoving all files except _site..\n"
git rm -rf .
# movie files in _site to root, remove _site
echo -e "\nExploding contents of _site to root..\n"
mv _site/* .
rm -rf _site

# commit and push to gh-pages
echo -e "\nStaging and committing to local gh-pages branch..\n"
git add .
git commit -m "Deploy site at $(date "+%Y-%m-%d %H:%M:%S")"
echo -e "\nPushing website to remote (gh-pages)..\n"
git push origin gh-pages

# switch back to main
git switch main
echo -e "\nPushing Jekyll structure to remote (main)..\n"
git push origin main

echo -e "Deployment complete!"


#!/bin/bash

# this deploy script builds the website (creating the _site directory) in main. _site is gitignored. it then switches to gh-pages, deletes everything except _site, moves the contents of _site to the root (and deletes _site), then stages, commits, and pushes to gh-pages remotely. 

# Function to display usage
usage() {
    echo "Usage: $0 [-b branch_name]"
    echo "  -b: Name of the branch containing changes to deploy (optional)"
    echo "  If no branch is specified, deploys all changes from main"
    exit 1
}

# Parse command line arguments
while getopts "b:" opt; do
    case $opt in
        b) DEPLOY_BRANCH="$OPTARG";;
        ?) usage;;
    esac
done

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
if [ -n "$DEPLOY_BRANCH" ]; then
    echo "Deploying changes from branch: $DEPLOY_BRANCH"
    git merge $DEPLOY_BRANCH --no-ff
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to merge changes from branch $DEPLOY_BRANCH"
        git merge --abort
        exit 1
    fi
    
    # Push the merged changes to main
    git push origin main
fi

echo -e "\nBuilding website to _site..\n"
bundle exec jekyll build

# Check if _site directory actually gets created (branch will always start without a _site dir)
if [[ ! -d "_site" ]]; then
    echo "Error: _site directory was not created. Jekyll build failed. Consider checking if ruby is being used."
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


BASE=$1
echo $BASE
BRANCH=$2

if [ -z "$BASE" -o -z "$BRANCH" ]
then
	echo "empty"
	BRANCH=$(git symbolic-ref HEAD | sed -e "s/^refs\/heads\///");
fi

echo "Base: $BASE .. Branch: $BRANCH"

GITPATH=$(git config --get remote.origin.url | sed -e "s/git@github.com://")
USER=$(echo $GITPATH | sed -e "s/\/.*//")

REPO=$(echo $GITPATH | sed -e "s/.*\///" | sed -e "s/\.git//")

URL=$(printf "https://github.com/%s/%s/compare/%s?expand=1" $USER $REPO $BRANCH)

if [ ! -z "$BASE" ]; then
	URL=$(printf "https://github.com/%s/%s/compare/%s...%s?expand=1" $USER $REPO $BASE $BRANCH)
fi

echo Opening pull request at $URL;

open $URL

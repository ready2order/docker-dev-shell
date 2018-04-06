#! /bin/sh

REPO=ready2order/dev-shell
USAGE="./build.sh VERSION [--push] [--login]"

# Ensure that script auto-stops on errors.
set -exo pipefail

echo "Arguments: $@"

VERSION=$1
PUSH=$2
LOGIN=$3

if [ -z "$VERSION" ]; then
    echo $USAGE
    exit 1
fi

FULL_TAG="$REPO:$VERSION"

if [ "$LOGIN" == "--login" ]; then
    echo $DOCKER_PW | docker login -u $DOCKER_USER  --password-stdin
fi

docker build -t $FULL_TAG .

if [ "$PUSH" == "--push" ]; then
    echo "Pushing image with tag $FULL_TAG...";
    docker push "$FULL_TAG"
fi

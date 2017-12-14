#!/bin/bash
set -eu
docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"
openssl aes-256-cbc -K $1 -iv $2 -in travis.enc -out travis -d
set -x
chmod 0400 travis
export GIT_SSH_COMMAND="ssh -i ${PWD}/travis"
cd helm-chart
./build.py --commit-range "${TRAVIS_COMMIT_RANGE}" --push --publish-chart

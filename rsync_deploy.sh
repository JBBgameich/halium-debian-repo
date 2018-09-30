#!/usr/bin/env bash

FILES="pool dists"

echo $DEPLOY_KEY_PRIVATE | base64 -d | xz -d > ~/.ssh/id_rsa
echo $DEPLOY_KEY_PUBLIC | base64 -d | xz -d > ~/.ssh/id_rsa.pub
chmod 400 ~/.ssh/id_rsa

# Deploy to server
rsync -avzP -e \
        "ssh -o StrictHostKeyChecking=no -p $DEPLOY_PORT" \
        $TRAVIS_BUILD_DIR/$FILES \
        $DEPLOY_ACCOUNT:/var/www/archive.kaidan.im/debian-pm/repo

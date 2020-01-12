#!/bin/bash
cd /src/app

if [ "$DEPLOY_ENV" = 'prod' ]; then
    echo "Running environment prod scripts"
        yarn
        yarn build
        yarn start
    exit
elif [ "$DEPLOY_ENV" = 'dev' ]; then
    echo "Running environment dev scripts"
        yarn
        yarn dev
    exit
elif [ "$DEPLOY_ENV" = 'studio' ]; then
    echo "Running studio"
        yarn
        prisma2 dev
    exit
elif [ "$DEPLOY_ENV" = 'default' ]; then
    echo "Initializing prisma2 app"
        prisma2 init
    exit
fi
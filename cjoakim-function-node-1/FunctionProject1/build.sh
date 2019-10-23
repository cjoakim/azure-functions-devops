#!/bin/bash

# Local workstation build script, similates the Azure DevOps Pipeline.
# Usage:
# ./build
# ./build local
# Chris Joakim, Microsoft, 2019/10/23

arg_count=$#

echo 'node --version'
node --version

echo 'npm --version'
npm --version

echo 'npm install'
npm install

echo 'npm outdated'
npm outdated

echo 'grunt'
grunt

# Default to authorized invocation
cp HttpTrigger/function-authorized.json  HttpTrigger/function.json

if [ $arg_count -gt 0 ]
then
    if [ $1 == "local" ]
    then
        echo "local build specified for anonymous function invocation"
        cp HttpTrigger/function-anonymous.json  HttpTrigger/function.json
    else
        echo "azure build specified for authorized function invocation"
        cp HttpTrigger/function-authorized.json  HttpTrigger/function.json
    fi
else 
    echo "azure build specified for authorized function invocation"
    cp HttpTrigger/function-authorized.json  HttpTrigger/function.json
fi

echo 'HttpTrigger/function.json contents:'
cat HttpTrigger/function.json

echo 'executing docker build...'
docker build -t cjoakim/azurefunctionproject1 .

echo 'listing the container image...'
docker image ls | grep azurefunctionproject1

echo 'done'

# docker run -e AZURE_REDISCACHE_NAMESPACE=$AZURE_REDISCACHE_NAMESPACE -e AZURE_REDISCACHE_KEY=$AZURE_REDISCACHE_KEY -p 8080:80 -it cjoakim/azurefunctionproject1:latest

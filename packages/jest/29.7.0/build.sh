#!/bin/bash

source environment

# Download and extract Node.js (adjust the version as needed)
curl -L https://nodejs.org/dist/v16.13.0/node-v16.13.0-linux-x64.tar.xz -o node.tar.xz
tar xf node.tar.xz --strip-components=1
rm node.tar.xz

npm install -g jest@29.7.0
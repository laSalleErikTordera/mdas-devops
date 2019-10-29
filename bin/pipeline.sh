#!/bin/bash

set -e
# CI/CD Pipeline for the project votingapp

# Clean-Up
rm -rf build

# Dependencies Install
go get github.com/gorilla/websocket
go get github.com/labstack/echo

mkdir build
mkdir build/votingapp

# Go Build
go build -o ./build/votingapp ./src/votingapp

# Copy static files
cp -r src/votingapp/ui build/votingapp/ui
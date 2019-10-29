#!/bin/bash

# CI/CD Pipeline for the project votingapp

# Clean-Up
rm -rf build

# Dependencies Install
go get github.com/gorilla/websocket
go get github.com/labstack/echo

# Go Build
go build -o build/votingapp/votingapp ./src/votingapp

# Copy static files
mkdir build
mkdir build/votingapp
cp -r src/votingapp/ui build/votingapp/ui
#!/bin/env bash

# find go.mod files and for each file see if it contains github.com/openshift/api and if so update it to latest or if it contains github.com/openshift/client-go update it to latest too

find . -name go.mod | while read -r go_mod_file; do
	if grep -q "github.com/openshift/api" "$go_mod_file"; then
		echo "Updating $go_mod_file"
		pushd $(dirname $go_mod_file)
		go get github.com/openshift/api@master
		go mod tidy
		popd
	fi
	if grep -q "github.com/openshift/client-go" "$go_mod_file"; then
		echo "Updating $go_mod_file"
		pushd $(dirname $go_mod_file)
		go get github.com/openshift/client-go@master
		go mod tidy
		popd
	fi
done

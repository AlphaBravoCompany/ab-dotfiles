#!/usr/bin/env bash

## Set scripts to be executable.
chmod +x scripts/*.sh

## Execute scripts.
scripts/install-omz.sh
scripts/sync.sh -f

## Update package managers
pip3 install --upgrade setuptools pip
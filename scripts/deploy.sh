#!/bin/bash
set -e

# run from the parent of the scripts directory (one level up)
echo "Deploying to stage ${stage}"
sls deploy --host "$(terraform output dbAddress)"
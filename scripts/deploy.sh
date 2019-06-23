#!/bin/bash
set -e

# run from the parent of the scripts directory (one level up)
echo "Deploying to stage ${stage}"

terraform init
terraform workspace select $stage || terraform workspace new $stage
terraform apply -var db_password="${dbPassword}" -auto-approve

sls deploy --host "$(terraform output dbAddress)"
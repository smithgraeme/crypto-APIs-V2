# run from the parent of the scripts directory (one level up)

echo "Deploying"
echo $env_name
pwd

terraform init
terraform workspace select $env_name || terraform workspace new $env_name
terraform apply -var db_password="$(cat tmp/DB_PW)" -auto-approve
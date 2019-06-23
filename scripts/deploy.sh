echo "Deploying"

terraform init
terraform workspace new dev
terraform workspace select dev
terraform apply -var db_password="$(cat dev/DB_PW)" -auto-approve
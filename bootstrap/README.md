<!-- "bootstrap" defines the S3 backend bucket and DynamoDB lock table

Is run once per environment

Can be used in CI/CD or manually to provision backend infrastructure -->

<!-- Why not include the backend in envs/dev, staging or prod?
Because Terraform can't manage the backend it’s using — 
if the backend resources are managed by the same configuration using that backend, 
we get a circular dependency. -->

# PROVIDERS:
# Required_version: Ensures Terraform CLI is at least v1.12.0.
# Required_providers: Locks the AWS provider to a compatible range (e.g., any 5.x version but not 6.x).
# ~> is the pessimistic constraint operator, commonly used for this.

# terraform fmt -recursive


# CREATE BACKEND

# 1 - Comment out the following in bootstrap/dev/main.tf

# terraform {
#   backend "s3" {}
# }

# create s3 and dynamoDB RUN>
# terraform init
# terraform apply

# 2 - initialize the backend (example dev)

# uncomment the previously commented out code

# terraform {
#   backend "s3" {}
# }


# Always wrap -backend-config paths in quotes to avoid shell interpretation issues

# RUN>

# terraform init -backend-config="../../backend/dev.tfbackend"

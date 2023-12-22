# Create Lambda Layer

In the project, we create Lambda layer for different scenarios.

## Examples

### Create a Lambda layer for `python` runtime with dependencies installed via `pip`

1. (null_resource) run pip install with requirements.txt in cwd
2. (archive_file) archive dependencies directory into zip file via cwd
3. (aws_lambda_layer_version) create layer with zip file

```bash
module "dependencies_lambda_layer" {
  source = "../01-modules/lambda_layer"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  layer_name  = "dependencies"
  pip_install = true
  from_local  = true
}
```

### Create a Lambda layer for `python` runtime with local built layer source code

1. (archive_file) archive layer source code directory into zip file via cwd
2. (aws_lambda_layer_version) create layer with zip file

```bash
module "custom_lambda_layer" {
  source = "../01-modules/lambda_layer"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  layer_name  = "custom"
  source_path = "core"
  is_custom   = true
  from_local  = true
}
```

### Create a Lambda layer for `python` runtime with dependencies installed via `pip`, then upload to s3 bucket

1. (null_resource) run pip install with requirements.txt in cwd
2. (archive_file) archive dependencies directory into zip file via cwd
3. (aws_s3_object) upload zip file to s3 bucket
4. (aws_lambda_layer_version) create layer with uploaded zip file in s3

```bash
module "remote_lambda_layer" {
  source = "../01-modules/lambda_layer"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  layer_name  = "remote"
  pip_install = true
  from_s3     = true
  s3_bucket   = var.s3_bucket
}
```

## Terraform Structure

```bash
.
├── .env.sample                     # file for environment variables
├── .terraform.lock.hcl
├── 01_variables.tf                 # All file with .tf extension are Terraform related
├── 01_versions.tf
├── 02_main.tf                      # Use modules for AWS resoures
├── 03_outputs.tf
├── Makefile                        # Make scripts
├── README.md
├── core                            # Source code for custom layer
│   └── python
├── requirements.txt                # External dependencies for layer (python only)
├── package-lock.json
├── package.json                    # Packages for layer (nodejs only)
├── tf_dev.tfvars                   # Terraform variables per env
├── tf_prod.tfvars
```

## Local Deploy

Create a `.env` from `env.sample`, and update environment variables as needed. The `.env` file won't be checked into your source code. After updated, these variables in `.env` will be injected into `Makefile` when you execute `make` commands. You can run `make check_env` to validate these variables.

Another option to specify value of variable is to provide the value in command which has high priority than `.env`. For example, use `make ENVIRONMENT=prod check_env` to overwrite the `ENVIRONMENT` variable to `prod` instead of `dev` defined in `.env`.

Setup local development and AWS credentials following [README](../README.md) before you can deploy AWS resources using below commands.

```bash
# Create a Terraform plan named `tfplan`
make plan

# Apply the plan `tfplan`
make apply
```

## Local Destroy

Run below commands to destroy resouces.

```bash
# Create a Terraform destroy plan named `tfplan`
make plan-destroy

# Apply the destroy plan `tfplan`
make apply
```

## GitHub Actions

You can also deploy the project to AWS account via GitHub Actions workflows. I created a workflow which has the same name of project directory. Follow [Setup GitHub Environment for GitHub Actions Workflows](../README.md#setup-github-environment-for-github-actions-workflows) to setup and run GitHub Actions workflow from console.

## References

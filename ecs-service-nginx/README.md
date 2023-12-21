# ECS Service (Replica) for NGINX

The terraform project is used to deploy a ECS service in AWS ECS Cluster for NGINX.

The Terraform resources deployed in the project include:

- An ECS service with scheduling strategy as DAEMON
- An ECS task definition for above service using docker image `camillehe1992/nginx:latest`
- An IAM task role attached on task

## Project Structure

```bash
.
├── .env.sample                 # file for environment variables
├── .terraform.lock.hcl
├── 01_data.tf                  # All file with .tf extensions are Terraform related
├── 01_local.tf
├── 01_variables.tf
├── 01_versions.tf
├── 02_main.tf
├── 02_roles.tf
├── 03_outputs.tf
├── Dockerfile                  # Dockerfile for custom nginx image
├── Makefile                    # Define several common useful Make scripts
├── nginx.conf                  # nginx configuration file
├── README.md
├── tf_dev.tfvars               # Terraform variables per environments
├── tf_prod.tfvars
```

## Build & Publish Docker Image

Use below command to publish Docker image to a docker registry, for example DockerHub.

```bash
make create-image
```

> The `make create-image` script creates a docker image that is compatiable with both amd64/arm64 Arch OS.

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

## References

- [Task role vs task execution role in Amazon ECS](https://towardsthecloud.com/amazon-ecs-task-role-vs-execution-role)

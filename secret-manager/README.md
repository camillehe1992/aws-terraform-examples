# Create Secrets in Secrets Manager

A sample terraform project that used to demonstrate how to save secret tokens in GitHub Actions secrets and deploy them into AWS Secret Manager.

In a real project, we need to save sensitive information, such as password, secret key, in a third-party tool for security instead of hard-coded in the source code. These secure tokens are retrieved from third-party tool before in CICD pipeline, and injected into Terrafrom variables during plan. In this demo, I use GitHub Actions secrets to save secure tokens and map them into environments of GitHub workflow.

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
├── tf_dev.tfvars                   # Terraform variables per env
├── tf_prod.tfvars
```

## Deploy from Local

Follow [README](../README.md) to setup local enviroment for Terraform deployment. Then under `secret-manager` directory, run below commands to deploy current project into AWS account.

```bash
make init

make plan

make apply
```

## Deploy via GitHub Actions Workflow

Before triggering the GitHub workflow from GitHub console, goto [Setup GitHub Environment for GitHub Actions Workflows](../README.md#setup-github-environment-for-github-actions-workflows) to setup Github Actions environment.

Besides, add another seceret named `TF_VAR_DATABASE_PASSWORD` which is the secure token we need to save into AWS Secrets Manager.

> `DATABASE_PASSWORD` is prefixed with `TF_VAR_` to distinguish Terraform secure variables with workflow secrets.

Then trigger the [workflow](../.github/workflows/secret-manager-apply.yaml) manually from GitHub console.

## References

- [Configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- [Using secrets in GitHub Actions](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)
- [Creating secrets for an environment](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-an-environment)

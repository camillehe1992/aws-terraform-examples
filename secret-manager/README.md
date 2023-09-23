A sample terraform project that used to demonstrate how to save secret tokens in GitHub Actions secrets and deploy them into AWS Secret Manager.

---
In a real project, we need to save sensitive information, such as password, secret key, in a third-party tool for security instead of hard-coded in the source code. These secure tokens are retrieved from third-party tool before in CICD pipeline, and injected into Terrafrom variables during plan. In this demo, I use GitHub Actions secrets to save secure tokens and map them into environments of GitHub workflow. 

## Terraform Structure
```bash
.
├── Makefile                    # a markfile for terraform commands 
├── README.md
├── main.tf                     # define the specs of secretsmanager module
├── modules
│   └── secretsmanager          # secretsmanager module
│       ├── locals.tf
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf                  # outputs of terraform
├── tf_dev.tfvars               # variables of terraform
├── variables.tf                # variables definition of terraform
└── versions.tf                 # terraform backend configuration and provider versions
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


## Reference
- https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
- https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
- https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-an-environment
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
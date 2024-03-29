# Host Static Website Content in AWS S3 Bucket

A demo project to create an AWS S3 bucket for static website hosting using Terraform. There is anther Github repository <https://github.com/camillehe1992/static-website-using-docsy-in-aws-s3> that used for source code of frontend docsy UI. These frontend source code will be built and uploaded to the pre created S3 bucket for static website hosting that automatically triggered by Github Actions.

## Project Structure

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

## Local Deploy

Create a `.env` from `env.sample`, and update environment variables as needed. The `.env` file won't be checked into your source code. After updated, these variables in `.env` will be injected into `Makefile` when you execute `make` commands. You can run `make check_env` to validate these variables.

Another option to specify value of variable is to provide the value in command which has high priority than `.env`. For example, use `make ENVIRONMENT=prod check_env` to overwrite the `ENVIRONMENT` variable to `prod` instead of `dev` defined in `.env`.

Setup local development and AWS credentials following [README](../README.md) before you can deploy AWS resources using below commands.

```bash
# Create a Terraform plan named `tfplan`
make plan

# Apply the plan `tfplan`
make apply

# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
#
# Outputs:
#
# website_endpoint = "docsy-portal-prod.s3-website-ap-southeast-1.amazonaws.com"
```

At this point, you will get `404 Not Found` if access the website via `website_endpoint` as above. After static content get uploaded to bucket, you should get the rendered content after refresh the page.

## Local Destroy

Run below commands to destroy resouces.

> For this demo, you should empty the S3 bucket manually from AWS console or by AWS CLI before deleting bucket. Otherwise the destroy process will be hung up in the creating process until timeout.

```bash
# Create a Terraform destroy plan named `tfplan`
make plan-destroy

# Apply the destroy plan `tfplan`
make apply
```

## References

- [Hosting a static website using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [Tutorial: Configuring a static website on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html)

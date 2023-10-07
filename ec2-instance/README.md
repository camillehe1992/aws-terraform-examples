A sample terraform project that used to demonstrate how to launch an EC2 instance with the given instance type and image architecture of the latest AMI.
___

To simplify the demo, no IAM role is attached on the EC2 instance. The instance is located in default VPC, Subnets and Security Group. Provide an existing key-pair in the `tf_dev.tfvars` using `key_name` variable if you want to assign to the new created EC2 instance. The creation of Key Pair is not in the scope of demo.

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
make apply-destroy
```

## References

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
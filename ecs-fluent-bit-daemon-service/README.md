The project is used to deploy a daemonset task for Fluent bit to in AWS ECS Cluster to enable centralized container logging with Fluent Bit. 

The Terraform resources deployed in the project includes:
- An ECS service with scheduling strategy as DAEMON
- An ECS task definition for above service using docker image `camillehe1992/fluent-bit:latest`
- An IAM task role attached on task

___

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
- https://towardsthecloud.com/amazon-ecs-task-role-vs-execution-role
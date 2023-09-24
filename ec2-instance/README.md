A sample terraform project that used to demonstrate how to launch an EC2 instance with the given instance type and image architecture of the latest AMI.
___

To simplify the demo, no IAM role is attached on the EC2 instance. The instance is located in default VPC, Subnets and Security Group. Provide an existing key-pair in the `tf_dev.tfvars` using `key_name` variable if you want to assign to the new created EC2 instance. The creation of Key Pair is not in the scope of demo.

## References

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
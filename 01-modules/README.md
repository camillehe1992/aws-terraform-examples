# Terraform Modules (Internal Used)

Modules are containers for multiple resources that are used together. A module consists of a collection of .tf and/or .tf.json files kept together in a directory.

## Get Started

To get started, you can create a new module named `cloudwatch_event` from template `01_template`.

```bash
cd 01-modules
cp -r 01_template cloudwatch_event
```

## Module Structure

The standard module structure is a file and directory layout we recommend for reusable modules.

```bash
.
├── README.md           # includes description of the module and what it should be used for. (Auto generated)
├── main.tf             # where all the resources are created
├── outputs.tf          # contain the declarations for variables, respectively
└── variables.tf        # contain the declarations for outputs, respectively
```

For a complex module, you can setup nested modules or separate the resources into particular file for better readability and orginazation.

## README Auto Generation

`terraform-docs` is a utility to generate documentation from Terraform modules in various output formats.

Follow the official [installation guideline][Installation] to install `terraform-docs`. Run below command to generate a README file for your module `cloudwatch_event`.

```bash
cd 01-modules
terraform-docs -c .terraform-docs.yml cloudwatch_event > cloudwatch_event/README.md
```

> To re-generate the README file to keep your docuement up to date if there is anything change on module.

[Installation]: https://terraform-docs.io/user-guide/installation/

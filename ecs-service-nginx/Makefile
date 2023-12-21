#########################################################################
# Terraform Makefile
#########################################################################
-include .env

SHELL := /bin/bash
BASE := $(shell /bin/pwd)
PIP ?= pip
TF ?= terraform
MAKE ?= make

VAR_FILE := $(BASE)/tf_$(ENVIRONMENT).tfvars

$(info AWS_ACCOUNT 		= $(AWS_ACCOUNT))
$(info AWS_REGION  		= $(AWS_REGION))
$(info STATE_BUCKET		= $(STATE_BUCKET))
$(info ENVIRONMENT 		= $(ENVIRONMENT))
$(info NICKNAME    		= $(NICKNAME))
$(info AWS_PROFILE 		= $(AWS_PROFILE))
$(info VAR_FILE 		= $(VAR_FILE))

$(info DESIRED_COUNT		= $(DESIRED_COUNT))

# Add defaults/common variables for all components
define DEFAULTS
-var-file=$(VAR_FILE) \
-var aws_profile=$(AWS_PROFILE) \
-var aws_region=$(AWS_REGION) \
-var desired_count=$(DESIRED_COUNT) \
-refresh=true
endef

override OPTIONS += $(DEFAULTS)

lint:
	$(info [*] Linting terraform)
	@$(TF) fmt -check -diff -recursive
	@$(TF) validate

check-env:
	$(info [*] Check Environment Done)
	@$(info $(shell aws sts get-caller-identity --profile $(AWS_PROFILE)))

init: check-env
	$(info [*] Init Terrafrom Infra)
	@$(TF) init -reconfigure \
		-backend-config="bucket=$(STATE_BUCKET)" \
		-backend-config="region=$(AWS_REGION)" \
		-backend-config="profile=$(AWS_PROFILE)" \
		-backend-config="key=$(NICKNAME)/$(ENVIRONMENT)/$(AWS_REGION)/terraform.tfstate"

plan: init
	$(info [*] Plan Terrafrom Infra)
	@$(TF) plan $(OPTIONS) -out tfplan

plan-destroy: init
	$(info [*] Plan Terrafrom Infra - Destroy)
	@$(TF) plan -destroy $(OPTIONS) -out tfplan

apply: init
	$(info [*] Apply Terrafrom Infra)
	@$(TF) apply tfplan

create-image:
	# docker buildx create --name multi-arch --platform "linux/arm64,linux/amd64"
	docker buildx build --platform linux/arm64,linux/amd64 --builder multi-arch \
		-t camillehe1992/nginx:latest --push .

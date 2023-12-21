#########################################################################
# Terraform Makefile
#########################################################################
-include .env

SHELL := /bin/bash
BASE := $(shell /bin/pwd)
TF ?= terraform

VAR_FILE := $(BASE)/tf_$(ENVIRONMENT).tfvars

$(info AWS_ACCOUNT 		= $(AWS_ACCOUNT))
$(info AWS_PROFILE 		= $(AWS_PROFILE))
$(info AWS_REGION  		= $(AWS_REGION))
$(info STATE_BUCKET		= $(STATE_BUCKET))
$(info ENVIRONMENT 		= $(ENVIRONMENT))
$(info NICKNAME    		= $(NICKNAME))
$(info VAR_FILE 		= $(VAR_FILE))

# Add defaults/common variables for all components
define DEFAULTS
-var-file=$(VAR_FILE) \
-var aws_profile=$(AWS_PROFILE) \
-var aws_region=$(AWS_REGION) \
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

get-secret:
	$(info [*] Retrieve DB secret from Secrets Manager)
	aws secretsmanager get-secret-value \
	--secret-id $(SECRET_ID) \
	--query SecretString \
	--profile $(AWS_PROFILE) \
	--output text

initialize-db:
	$(info [*] Initialize RDS database via Lambda function)
	aws lambda invoke \
		--function-name ${FUNC_ARN} \
		--cli-binary-format raw-in-base64-out \
		--profile $(AWS_PROFILE) \
		response.json

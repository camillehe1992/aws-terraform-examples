#########################################################################
# Terraform Makefile
#########################################################################
-include .env

SHELL := /bin/bash
BASE := $(shell /bin/pwd)
PIP ?= pip
TF ?= terraform
MAKE ?= make

$(info AWS_ACCOUNT 		= $(AWS_ACCOUNT))
$(info AWS_REGION  		= $(AWS_REGION))
$(info ENVIRONMENT 		= $(ENVIRONMENT))
$(info NICKNAME    		= $(NICKNAME))

STATE_BUCKET := tf-state-$(AWS_ACCOUNT)-$(AWS_REGION)
AWS_PROFILE := service.app-deployment-${ENVIRONMENT}-ci-bot
VAR_FILE := $(BASE)/terraform.tfvars

$(info STATE_BUCKET 	= $(STATE_BUCKET))
$(info AWS_PROFILE 		= $(AWS_PROFILE))
$(info VAR_FILE 		= $(VAR_FILE))

lint:
	$(info [*] Linting terraform)
	@$(TF) fmt -check -diff -recursive
	@$(TF) validate

check_env:
	$(info [*] Check Terraform Environmets)

init: check_env
	$(info [*] Init Terrafrom Infra)
	@$(TF) init -reconfigure \
		-backend-config="bucket=$(STATE_BUCKET)" \
		-backend-config="region=$(AWS_REGION)" \
		-backend-config="profile=$(AWS_PROFILE)" \
		-backend-config="key=$(NICKNAME)/$(ENVIRONMENT)/$(AWS_REGION)/terraform.tfstate"

plan: init
	$(info [*] Plan Terrafrom Infra)
	@$(TF) plan -var-file $(VAR_FILE) \
		-var="aws_profile=${AWS_PROFILE}" \
		-var="database_password=${DATABASE_PASSWORD}" \
		-out tfplan

plan-destroy: init
	$(info [*] Plan Terrafrom Infra - Destroy)
	@$(TF) plan -destroy -var-file terraform/environments/$(ENVIRONMENT)/terraform.tfvars -out tfplan

apply: plan
	$(info [*] Apply Terrafrom Infra)
	@$(TF) apply tfplan

apply-destroy: plan-destroy
	$(info [*] Apply Terrafrom Infra - Destroy)
	@$(TF) apply tfplan
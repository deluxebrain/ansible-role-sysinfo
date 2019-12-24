.DEFAULT_GOAL := help

APP_NAME="ansible-role-sysinfo"

.PHONY: help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' Makefile \
		| awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' \
		| sed -e 's/\[32m##/[33m/'

## Ansible targets

.PHONY: lint
lint: ## Run project linter
	@ansible-lint .

## Vagrant targets

.PHONY: provision
provision: ## Re-run Vagrant ansible provisioners
	@vagrant provision --provision-with ansible

## Project targets

.PHONY: clean
clean: ## Teardown working environment
	@vagrant destroy --force
	@vboxmanage list runningvms \
	| grep ${APP_NAME} \
	| awk '{ print $$2 }' \
	| xargs -I vmid vboxmanage controlvm vmid poweroff
	@vboxmanage list vms \
	| grep ${APP_NAME} \
	| awk '{ print $$2 }' \
	| xargs -I vmid vboxmanage unregistervm vmid

SHELL := /bin/bash

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: decrypt
decrypt: ## decrypt file
	openssl aes-256-cbc -d -md sha256 -in terraform/components/$(target)/$(file).cipher -out terraform/components/$(target)/$(file) -pass env:DECRYPT_PASSWD

.PHONY: encrypt
encrypt: ## encrypt file
	openssl aes-256-cbc -e -md sha256 -in terraform/components/$(target)/$(file) -out terraform/components/$(target)/$(file).cipher -pass env:DECRYPT_PASSWD

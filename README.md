# Techlete Infrastructure

[![CI](https://github.com/Techlete/Infrastructure/actions/workflows/checkov.yml/badge.svg)](https://github.com/Techlete/Infrastructure/actions/workflows/checkov.yml)
[![Deploy](https://github.com/Techlete/Infrastructure/actions/workflows/continuous-deployment.yml/badge.svg)](https://github.com/Techlete/Infrastructure/actions/workflows/continuous-deployment.yml)

This repo is for Infrastructure documentation, including an operator manual & IaC.

## Git

GitHub is full of examples of terraform IaC that we can use via submodules within our `modules` folder, or `components` folder. Preference should be given to `modules` and care should be taken when using third-party code; however it is likely to have further benefits in operator knowledge, and time-to-market.

`git submodule init` after pull / clone is advised to avoid problems using this repo

## Terraform

The IaC within this repo uses terraform to setup AWS and other provider assets.

### Organisation

This repo uses `modules` as re-usable blocks to build higher-order `components` with. This is the reason for this folder structure.

Modules should be kept as focused as possible, but larger than the raw primitives they use. Where raw primitives can be used alone, build a module and try to define conventions to reduce boilerplate.

### Usage

Each component should be standalone and support the reverting of Git commits.

`data` blocks will permit passing of existing resources between components, which will be terraform applied separately. Failing 404's should only be as a result of needing to run a prior component first, and care should be taken to document this in the component-local `README.md` file.

The three commands after successful install of terraform should be

1. terraform init
2. terraform plan
3. terraform apply

#### State

State should be stored encrypted within this repository when it contains secrets.

This means that .tfstate files for components with secrets, should be encrypted before commit, and decrypted before use to prevent secrets being leaked. Where secrets are not contained, it is a time saving and desirable to store the .tfstate file.

##### Usage

- `make decrypt target="bootstrap" file="terraform.tfstate"`
- `make encrypt target="bootstrap" file="terraform.tfstate"`

Above is an example of encrypting and decrypting the `bootstrap` component and the output `terraform.tfstate` file.

Should you wish to encrypt another file, such as locals.tf for storing constants that may be sensetive or non-public, then just change the `file=..."` parameter to the make encrypt / decrypt.

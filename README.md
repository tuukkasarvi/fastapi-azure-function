# FastAPI as Azure function

Minimal example of FastAPI deployed as Azure function.

## Project structure
```
fastapi-azure-function
├── function/                                       Azure function and FastAPI code
├── infra/                                          Terraform code
└── README.md
```

## Prerequisites

- Azure Credentials: You'll need an Azure account with the necessary permissions to create the resources for the Azure function.
- Azure CLI: Install Azure CLI.
- Terraform: Install Terraform.

## Usage

Login to Azure and change to infra-directory.
```sh
az login
cd infra
```

Initialize Terraform.
```sh
terraform init
```

Terraform plan.
```sh
terraform plan
```

Terraform apply.
```sh
terraform apply
```

Terraform apply will output the URL of your deployed function, for example https://function-app-5aia.azurewebsites.net. In browser navigate to FastAPI docs https://function-app-5aia.azurewebsites.net/docs. From there you can send test requests to each of the endpoints.

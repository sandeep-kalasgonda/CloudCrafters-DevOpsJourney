# Terraform Run Notes

## 1. Prerequisites

### Install Terraform

Update your system packages:
```bash
sudo apt update && sudo apt upgrade -y
```

Download Terraform:
```bash
sudo apt install -y software-properties-common
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

Verify installation:
```bash
terraform version
```

### Install AWS CLI

Download and install AWS CLI:
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Verify installation:
```bash
aws --version
```

Configure AWS CLI:
```bash
aws configure
```
Provide:
- Access Key ID
- Secret Access Key
- Region (e.g., us-east-1)
- Output format (e.g., json)

### Install Azure CLI

Install Azure CLI using Microsoft’s repository:
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verify installation:
```bash
az version
```

Login to Azure:
```bash
az login
```
Follow the link provided in the terminal and authenticate with your Azure account.

## 2. Terraform Workflow with AWS

### Example: Creating an S3 Bucket

#### Initialize a Terraform Directory

Create and move into a working directory:
```bash
mkdir terraform-aws-example && cd terraform-aws-example
```

#### Write a Configuration File

Create a `main.tf` file:
```hcl
provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
    bucket = "my-unique-bucket-name-123"
    acl    = "private"
}

output "bucket_name" {
    value = aws_s3_bucket.example.bucket
}
```

#### Initialize Terraform

Download provider plugins and prepare the environment:
```bash
terraform init
```

#### Validate Configuration

Check for syntax errors:
```bash
terraform validate
```

#### Plan the Deployment

Preview the resources that Terraform will create:
```bash
terraform plan
```

#### Apply the Configuration

Create the resources:
```bash
terraform apply
```
Confirm by typing `yes` when prompted.

#### Verify the Resource

Go to the AWS Management Console to confirm the bucket has been created.

#### Destroy the Resource

To clean up and remove the resources:
```bash
terraform destroy
```
Confirm by typing `yes` when prompted.

## 3. Terraform Workflow with Azure

### Example: Creating a Resource Group

#### Write a Configuration File

Create a `main.tf` file:
```hcl
provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "example" {
    name     = "example-resources"
    location = "East US"
}

output "resource_group_name" {
    value = azurerm_resource_group.example.name
}
```

#### Initialize Terraform

```bash
terraform init
```

#### Validate, Plan, and Apply

Validate:
```bash
terraform validate
```

Plan:
```bash
terraform plan
```

Apply:
```bash
terraform apply
```
Confirm by typing `yes`.

#### Verify the Resource

Check the Azure Portal to confirm the resource group is created.

#### Destroy the Resource

```bash
terraform destroy
```

## Key Notes

- Always use a version control system (e.g., Git) to track changes in your Terraform configurations.
- Store sensitive data like access keys securely using environment variables or tools like HashiCorp Vault.
- Use `terraform fmt` to keep configurations clean and consistent.
- Leverage remote state storage (e.g., AWS S3, Azure Blob Storage) for collaboration.

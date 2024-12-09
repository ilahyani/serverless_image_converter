# Serverless Image Processing with AWS Lambda and Terraform

This project sets up a serverless infrastructure for image processing using AWS Lambda, Terraform, and Node.js. The infrastructure is provisioned using Vagrant and Terraform, and the Lambda function is written in Node.js.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)

## Prerequisites

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Terraform](https://www.terraform.io/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Node.js](https://nodejs.org/)

## Installation

1. **Clone the repository:**

    ```sh
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

2. **Set up environment variables:**

    Make sure you have the following environment variables exported in your shell with your AWS Credentials

    ```sh
    AWS_ACCESS_KEY_ID=your_access_key_id
    AWS_SECRET_ACCESS_KEY=your_secret_access_key
    AWS_REGION=your_aws_region
    ```

3. **Run Vagrant to provision the infrastructure:**

    ```sh
    vagrant up
    ```

    This will execute the [``init.sh``](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FUsers%2Filahyani%2Fserverless_webp_converter%2Finit.sh%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/Users/ilahyani/serverless_webp_converter/init.sh") script to install necessary tools and set up the infrastructure.



### Key Files and Directories

- **[``init.sh``](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FUsers%2Filahyani%2Fserverless_webp_converter%2Finit.sh%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/Users/ilahyani/serverless_webp_converter/init.sh")**: Script to set up the environment and install necessary tools.
- **[``function/``](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FUsers%2Filahyani%2Fserverless_webp_converter%2Ffunction%2F%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/Users/ilahyani/serverless_webp_converter/function/")**: Contains the Node.js Lambda function code.
- **[``terraform/``](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FUsers%2Filahyani%2Fserverless_webp_converter%2Fterraform%2F%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/Users/ilahyani/serverless_webp_converter/terraform/")**: Contains Terraform configuration files for provisioning AWS resources.
- **[``.github/workflows/main.yml``](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FUsers%2Filahyani%2Fserverless_webp_converter%2F.github%2Fworkflows%2Fmain.yml%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/Users/ilahyani/serverless_webp_converter/.github/workflows/main.yml")**: GitHub Actions workflow for deploying the infrastructure.

## Configuration

The configuration for the Lambda function and other resources is managed through Terraform variables. These variables are defined in [``terraform/modules/lambda/variables.tf``](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FUsers%2Filahyani%2Fserverless_webp_converter%2Fterraform%2Fmodules%2Flambda%2Fvariables.tf%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/Users/ilahyani/serverless_webp_converter/terraform/modules/lambda/variables.tf") and can be set in the [``.github/workflows/main.yml``](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FUsers%2Filahyani%2Fserverless_webp_converter%2F.github%2Fworkflows%2Fmain.yml%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/Users/ilahyani/serverless_webp_converter/.github/workflows/main.yml") file or `terraform/terraform.tfvars` if you're working locally.

### Example Variables

```yml
env:
    TF_VAR_lambda_function_name: "webp_convert"
    TF_VAR_lambda_runtime: "nodejs18.x"
    TF_VAR_lambda_handler: "index.handler"
    TF_VAR_lambda_src_code: "../function"
    TF_VAR_lambda_zip: "./lambda.zip"
    TF_VAR_original_files_bucket_name: "bucket-orginal-file"
    TF_VAR_edited_files_bucket_name: "bucket-edit-file"
```
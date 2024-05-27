# Variables Configuration for API Gateway with Lambda Stack

This README outlines the variables used in the Terraform configuration for setting up an API Gateway with Lambda functions.

## Variables

### `lambda_functions`
This variable defines a map of objects where each object represents a Lambda function configuration. Each function configuration includes the following attributes:

- `function_name`: The name of the Lambda function.
- `runtime`: The runtime environment for the Lambda function (e.g., `nodejs18.x`).
- `route_key`: The route key associated with the function in API Gateway.
- `source_file`: The local path to the source file of the Lambda function.
- `output_path`: The path where the zipped source file will be stored.
- `filename`: The name of the output file (typically a `.zip` file).

#### Default Configuration
- **function1**:
  - `function_name`: "lambda1"
  - `runtime`: "nodejs18.x"
  - `route_key`: "function1"
  - `source_file`: "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler1/index.js"
  - `output_path`: "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler1/index.zip"
  - `filename`: "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler1/index.zip"

- **function2**:
  - `function_name`: "lambda2"
  - `runtime`: "nodejs18.x"
  - `route_key`: "function2"
  - `source_file`: "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler2/index.js"
  - `output_path`: "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler2/index.zip"
  - `filename`: "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler2/index.zip"

### `stage_name`
- **Type**: string
- **Default**: "ishwar-stage"
- **Description**: The name of the deployment stage in API Gateway.

### `api_name`
- **Type**: string
- **Default**: "lambda-http-api"
- **Description**: The name of the API Gateway.

## Usage
To use these variables, reference them in your Terraform configurations where needed. Ensure that the paths and names are correctly set according to your local environment and AWS setup.

main.tf
```
module "lambda-and-api" {
  source = "./api-gateway-with-lambda-stack"
}
```
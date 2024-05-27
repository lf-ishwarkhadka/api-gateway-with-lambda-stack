variable "lambda_functions" {

  type = map(object({

    function_name = string
    runtime = string
    route_key = string
    source_file = string
    output_path = string
    filename = string
  }))

  default = {

    function1 = {

      function_name = "lambda1"
      runtime = "nodejs18.x"
      route_key = "function1"
      source_file = "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler1/index.js"
      output_path = "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler1/index.zip"
      filename = "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler1/index.zip"
    }

    function2 = {

      function_name = "lambda2"
      runtime = "nodejs18.x"
      route_key = "function2"
      source_file = "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler2/index.js"
      output_path = "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler2/index.zip"
      filename = "/home/leapfrog/IshwarKhadka/training/s3-cloudfront module/api-gateway-and-lambda-stack/handler2/index.zip"
    }

  
  }

}

variable "stage_name"{
  type = string         
  default = "ishwar-stage"
}

variable "api_name" {
  type = string
  default = "lambda-http-api"
}


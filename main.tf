data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  for_each = var.lambda_functions
  type        = "zip"
  source_file = each.value.source_file
  output_path = each.value.output_path
}
resource "aws_lambda_function" "lambda_function" {
  for_each = var.lambda_functions
  filename         = each.value.filename
  function_name    = each.value.function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda[each.key].output_base64sha256
  runtime          = each.value.runtime
}


resource "aws_apigatewayv2_api" "lambda_api" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "apigateway_stage" {
  api_id      = aws_apigatewayv2_api.lambda_api.id
  name        = var.stage_name
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  for_each = var.lambda_functions
  api_id             = aws_apigatewayv2_api.lambda_api.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_function[each.key].invoke_arn
}

resource "aws_apigatewayv2_deployment" "apigateway_depolyment" {
  api_id      = aws_apigatewayv2_api.lambda_api.id
  description = "ApI Gateway deployment"
  
  depends_on = [
    aws_apigatewayv2_route.apigateway_route
  ]

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_apigatewayv2_route" "apigateway_route" {
  for_each = var.lambda_functions
  api_id    = aws_apigatewayv2_api.lambda_api.id
  route_key = "GET /${each.value.route_key}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration[each.key].id}"
}

resource "aws_lambda_permission" "api_gw" {
  for_each = var.lambda_functions
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function[each.key].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

# Lambda IAM Role 
resource "aws_iam_role" "lambda_exec" {
  name = "${var.environment}-alb-nlb-sync-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Policy for Lambda to access ALB and NLB
resource "aws_iam_role_policy" "lambda_permissions" {
  name = "${var.environment}-alb-nlb-sync-policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:RegisterTargets"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}


# Lambda function to sync ALB and NLB target groups
resource "aws_lambda_function" "alb_to_nlb_sync" {
  function_name = "${var.environment}-alb-nlb-sync"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.12"
  filename      = "${path.module}/function.zip"
  source_code_hash = filebase64sha256("${path.module}/function.zip")

  environment {
    variables = {
      ALB_DNS_NAME = var.alb_dns_name
      NLB_TARGET_GROUP_ARN = var.nlb_target_group_arn
    }
  }

  timeout = 10
}



# CloudWatch Scheduled Event Rule
resource "aws_cloudwatch_event_rule" "every_10_minutes" {
  name                = "${var.environment}-alb-nlb-sync-schedule"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.every_10_minutes.name
  target_id = "lambda"
  arn       = aws_lambda_function.alb_to_nlb_sync.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.alb_to_nlb_sync.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_10_minutes.arn
}

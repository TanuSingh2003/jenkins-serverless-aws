resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/notes-api"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "lambda-error-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Alarm if lambda has any errors"
  dimensions = {
    FunctionName = "notes-api"
  }
}


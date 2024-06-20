resource "aws_cloudwatch_log_group" "sftp_logs" {
  name = "/aws/transfer/sftp"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "sftp_failures" {
  alarm_name          = "SFTPConnectionFailures"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ConnectionFailures"
  namespace           = "AWS/Transfer"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"

  alarm_actions = [aws_sns_topic.sftp_alerts.arn]
}

resource "aws_sns_topic" "sftp_alerts" {
  name = "SFTPAlerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.sftp_alerts.arn
  protocol  = "email"
  endpoint  = "brijeshb9498@gmail.com"
}

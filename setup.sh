#! /usr/bin/env bash

# Create a rule to enable CloudWatch events for all Amazon GuardDuty findings
aws events put-rule --name AmazonGuardDutyFindings --event-pattern '{"source":["aws.guardduty"]}' --profile trend

# Connect our AWS Lambda function to all findings
aws events put-targets --rule AmazonGuardDutyFindings --targets Id=1,Arn=arn:aws:lambda:ap-southeast-1:650143975734:function:ds-gd-dev-guardduty-response --profile trend

# Set the invocation rights for the AWS Lambda function
aws lambda add-permission --function-name ds-gd-dev-guardduty-response --statement-id 1 --action 'lambda:InvokeFunction' --principal events.amazonaws.com --profile trend
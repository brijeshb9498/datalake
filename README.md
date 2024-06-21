# Data Lake SFTP Solution

## Overview
This repository contains Terraform configurations and Lambda functions for setting up an SFTP solution on AWS.



## Setup Instructions
1. Clone the repository.
2. Configure AWS CLI with appropriate permissions.
3. Run `terraform init` to initialize Terraform.
4. Run `terraform apply` to deploy the infrastructure.

## Components
- **SFTP Server**: AWS Transfer Family server for SFTP.
- **S3 Bucket**: Storage for uploaded data with lifecycle policies.
- **IAM Roles and Policies**: Secure access management.
- **Lambda Functions**: For data processing and user management.
- **Monitoring and Alerts**: CloudWatch Alarms and SNS notifications.

## Onboarding/Offboarding Agencies
Use the `OnboardingHandler` Lambda function to automate user management.

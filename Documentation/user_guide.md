                          ****Data Lake SFTP Solution Documentation****
**Overview**
This documentation provides a detailed guide for setting up a secure SFTP solution on AWS using AWS Transfer Family, S3, IAM, Lambda, CloudWatch, and Terraform. The solution allows agencies to upload data files (CSV, Excel, JSON) to an S3 bucket in the eu-west-1 region.

**Architecture**
The solution includes the following components:

1) AWS Transfer Family: Managed SFTP server.
2) S3 Bucket: Storage for uploaded data with lifecycle policies.
3) IAM Roles and Policies: Secure access management.
4) Lambda Functions: For data processing and user management.
5) CloudWatch: Monitoring and logging.
6) SNS: Notifications for missing data incidents.


**Setup Instructions**
Prerequisites
AWS CLI configured with appropriate permissions.
Terraform installed on your machine.
A GitHub repository to host the code

**Step-by-Step Guide**
1) Clone the Repository (git clone)
2) Initialize Terraform ( terraform init )
3) Apply Terraform Configurations ( terraform plan and terraform apply)
4) Verify the Setup
  1)Check the AWS Transfer Family console to verify the SFTP server is running.
  2)Check the S3 bucket to ensure it's created and accessible.
  3)Verify the IAM roles and policies are correctly applied.
  4)Test the Lambda functions by uploading test files to the S3 bucket and checking for logs in CloudWatch.
  5)Ensure SNS notifications are set up correctly and the SRE team email is subscribed.


**Detailed Component Descriptions**

**AWS Transfer Family (SFTP Server)**
Terraform Configuration (sftp.tf): This configuration sets up an SFTP server with a public endpoint and service-managed user authentication.

**S3 Bucket**
Terraform Configuration (s3.tf):This configuration creates an S3 bucket with a lifecycle rule to move data to Glacier storage after 30 days for cost optimization.

**IAM Roles and Policies**
Terraform Configuration (iam.tf):This configuration creates an IAM role and policy to allow the SFTP server to access the S3 bucket with the least privilege.

**Lambda Functions**
Data Processing Lambda
Lambda Function Code (lambda/process_data.py), Terraform Configuration (lambda.tf): This configuration sets up a Lambda function to process files upon upload to S3 and triggers it using S3 events.

Onboarding/Offboarding Lambda
Lambda Function Code (lambda/onboarding.py), Terraform Configuration (lambda.tf): This configuration sets up a Lambda function to handle the creation and deletion of SFTP users, enabling automated onboarding and offboarding.

**Monitoring and Alerts**
Terraform Configuration (monitoring.tf): his configuration sets up CloudWatch Logs for SFTP server logs, creates a CloudWatch alarm for SFTP connection failures, and sends notifications to an SNS topic which emails the SRE team.

**Cost Optimization**
Implemented S3 Lifecycle Policies
As mentioned in the S3 bucket configuration, lifecycle policies are set up to move data to Glacier storage after 30 days to minimize storage costs.


**Components**
SFTP Server: AWS Transfer Family server for SFTP.
S3 Bucket: Storage for uploaded data with lifecycle policies.
IAM Roles and Policies: Secure access management.
Lambda Functions: For data processing and user management.
Monitoring and Alerts: CloudWatch Alarms and SNS notifications.
Onboarding/Offboarding Agencies
Using the OnboardingHandler Lambda function to automate user management.

**Cost Optimization**
Implemented S3 lifecycle policies to move data to Glacier storage after 30 days.

Monitoring and Alerts
Setting up CloudWatch Alarms
CloudWatch alarms are configured to monitor SFTP connection failures and notify the SRE team via SNS.
Testing Notifications
Simulate a connection failure to trigger the CloudWatch alarm.
Check the SRE team email for notifications from SNS.

Monitoring and Alerts
Setting up CloudWatch Alarms
CloudWatch alarms are configured to monitor SFTP connection failures and notify the SRE team via SNS.
Testing Notifications
Simulate a connection failure to trigger the CloudWatch alarm.
Check the SRE team email for notifications from SNS.

**Rollback and Cleanup**
To destroy the infrastructure, use Terraform:
*terraform destroy*
Verify that all resources, including the SFTP server, S3 bucket, IAM roles, and Lambda functions, are deleted from the AWS console.

**Security and Compliance**
*Principle of Least Privilege*: All IAM policies are configured to grant the minimum permissions necessary.
*PII Protection*: The S3 bucket is private and accessible only via the SFTP server and specific IAM roles.
*Monitoring and Logging*: CloudWatch Logs are enabled for the SFTP server and Lambda functions to track access and actions.

**Conclusion**
By following this documentation, you can set up a robust, secure, and automated SFTP solution on AWS, ensuring compliance with infrastructure as code principles, security best practices, and cost optimization strategies.

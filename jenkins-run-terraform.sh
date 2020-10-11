#!/bin/bash
set -ex
AWS_REGION="us-east-1"
#cd jenkins-packer-demo
S3_BUCKET="cloudzone99"
aws s3 ls s3://${S3_BUCKET}/amivar.tf --region $AWS_REGION
aws s3 cp s3://${S3_BUCKET}/amivar.tf amivar.tf --region $AWS_REGION
terraform init
#terraform apply -auto-approve -var APP_INSTANCE_COUNT=1 -target aws_instance.app-instance
terraform apply -auto-approve -var APP_INSTANCE_COUNT=1

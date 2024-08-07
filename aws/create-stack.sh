#!/bin/bash

# Prompt for the password
echo -n "Enter the database password: "
read -s DB_PASSWORD
echo

# Use the AWS CLI to create the CloudFormation stack
aws cloudformation create-stack \
  --stack-name postgres \
  --template-body "$(cat aurora-serverless.yaml)" \
  --parameters ParameterKey=DBPassword,ParameterValue="$DB_PASSWORD" \
  --capabilities CAPABILITY_NAMED_IAM \
  --region eu-central-1
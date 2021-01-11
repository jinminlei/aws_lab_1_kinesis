# Create the stack
aws cloudformation create-stack --stack-name aws-kinesis --template-body file://aws-bigdata.yaml --parameters ParameterKey=StackName,ParameterValue=aws-kinesis --capabilities '[\"CAPABILITY_AUTO_EXPAND\", \"CAPABILITY_NAMED_IAM\", \"CAPABILITY_IAM\"]' --region us-east-1 --profile default

# Create role for aws glue
aws iam create-role --role-name AWSGlueServiceRoleDefault --assume-role-policy-document file://trust-policy.json --region us-east-1 --profile default
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --role-name AWSGlueServiceRoleDefault --region us-east-1 --profile default
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole --role-name AWSGlueServiceRoleDefault --region us-east-1 --profile default
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess --role-name AWSGlueServiceRoleDefault --region us-east-1 --profile default
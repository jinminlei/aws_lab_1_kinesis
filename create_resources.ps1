# Create the stack
aws cloudformation create-stack --stack-name aws-kinesis --template-body file://aws-bigdata.yaml --parameters ParameterKey=StackName,ParameterValue=aws-kinesis --profile default --region us-east-1 --capabilities '[\"CAPABILITY_AUTO_EXPAND\", \"CAPABILITY_NAMED_IAM\", \"CAPABILITY_IAM\"]'
# Sign up a cognito user 
aws cognito-idp sign-up --region us-east-1 --client-id 4rv30fp5vl0aoui8b0ijh3km5g --username leijinmin@gmail.com --password !MyPassword1 --user-attributes Name=name,Value=leijinmin Name=email,Value=leijinmin@gmail.com
# Confirm the sign up 
aws cognito-idp admin-confirm-sign-up --user-pool-id us-east-1_MAT1UpOr5  --username leijinmin@gmail.com
# Open the Kinesis Generator and add the cognito configuration
# https://awslabs.github.io/amazon-kinesis-data-generator/web/producer.html?upid=us-east-1_MAT1UpOr5&ipid=us-east-1:86098687-2734-495d-a06b-20308035aca2&cid=4rv30fp5vl0aoui8b0ijh3km5g&r=us-east-1

# Create role for aws glue
aws iam create-role --role-name AWSGlueServiceRoleDefault --assume-role-policy-document file://trust-policy.json
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --role-name AWSGlueServiceRoleDefault
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole --role-name AWSGlueServiceRoleDefault
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess --role-name AWSGlueServiceRoleDefault
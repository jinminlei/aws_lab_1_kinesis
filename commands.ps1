# Create the resources
aws cloudformation create-stack --stack-name aws-kinesis --template-body file://aws-bigdata.yaml --parameters ParameterKey=StackName,ParameterValue=aws-kinesis --profile default --region us-east-1 --capabilities '[\"CAPABILITY_AUTO_EXPAND\", \"CAPABILITY_NAMED_IAM\", \"CAPABILITY_IAM\"]'
# Sign up a cognito user 
aws cognito-idp sign-up --region us-east-1 --client-id 4rv30fp5vl0aoui8b0ijh3km5g --username leijinmin@gmail.com --password !MyPassword1 --user-attributes Name=name,Value=leijinmin Name=email,Value=leijinmin@gmail.com
# Confirm the sign up 
aws cognito-idp admin-confirm-sign-up --user-pool-id us-east-1_MAT1UpOr5  --username leijinmin@gmail.com
# Open the Kinesis Generator
# https://awslabs.github.io/amazon-kinesis-data-generator/web/producer.html?upid=us-east-1_MAT1UpOr5&ipid=us-east-1:86098687-2734-495d-a06b-20308035aca2&cid=4rv30fp5vl0aoui8b0ijh3km5g&r=us-east-1

# TODO create role JinminAWSGlueServiceRoleDefault
# 1. Assume role policy
# 2. Policy document
aws iam create-role --role-name AWSGlueServiceRoleDefault --assume-role-policy-document file://trust-policy.json
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --role-name AWSGlueServiceRoleDefault
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole --role-name AWSGlueServiceRoleDefault
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess --role-name AWSGlueServiceRoleDefault


# Create crawler
# Should be update crawler
# test if it should be update-crawler,because the previoulsy created table daily_avg_inefficiency has been blown away
aws --region us-east-1 glue create-crawler --name 'thermostat-data-crawler' --database-name 'awsblogsgluedemo' --role 'JinminAWSGlueServiceRoleDefault' --targets 'file://crawler-targets.json'
# Recreate the table updated by the above command
aws glue create-table --database-name awsblogsgluedemo --table-input   file://table.json  --profile default --region us-east-1 --endpoint https://glue.us-east-1.amazonaws.com
# Create crawler job
aws --region us-east-1 glue create-job --name 'daily_avg' --role 'JinminAWSGlueServiceRoleDefault' --execution-property 'MaxConcurrentRuns=1' --command '{\"Name\": \"glueetl\", \"ScriptLocation\": \"s3://aws-kinesis-bucket/etl_code/daily_avg.py\"}'
# open the job
# https://console.aws.amazon.com/glue/home?region=us-east-1#editJob:isNewlyCreated=false;jobName=daily_avg


# delete resources
aws glue delete-job --job-name jinmin-daily_avg
aws glue delete-database --name awsblogsgluedemo
aws cloudformation delete-stack --stack-name aws-kinesis

aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole
aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess
aws iam delete-role --role-name AWSGlueServiceRoleDefault 


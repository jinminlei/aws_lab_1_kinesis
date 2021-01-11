# delete resources
aws glue delete-job --job-name daily_avg --region us-east-1 --profile default
aws glue delete-database --name awsblogsgluedemo --region us-east-1 --profile default
aws glue delete-crawler --name thermostat-data-crawler --region us-east-1 --profile default
aws cloudformation delete-stack --stack-name aws-kinesis --region us-east-1 --profile default

aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --region us-east-1 --profile default
aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole --region us-east-1 --profile default
aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess --region us-east-1 --profile default
aws iam delete-role --role-name AWSGlueServiceRoleDefault --region us-east-1 --profile default


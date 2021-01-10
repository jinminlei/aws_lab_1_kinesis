# delete resources
aws glue delete-job --job-name jinmin-daily_avg
aws glue delete-database --name awsblogsgluedemo
aws cloudformation delete-stack --stack-name aws-kinesis

aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole
aws iam detach-role-policy --role-name AWSGlueServiceRoleDefault --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess
aws iam delete-role --role-name AWSGlueServiceRoleDefault 


# Create job
aws glue create-job --name 'daily_avg' --role 'AWSGlueServiceRoleDefault' --execution-property 'MaxConcurrentRuns=1' --command '{\"Name\": \"glueetl\", \"ScriptLocation\": \"s3://aws-kinesis-bucket/etl_code/daily_avg.py\"}' --profile default --region us-east-1
# Run the job
aws glue start-job-run --job-name 'daily_avg'
# open the job
# https://console.aws.amazon.com/glue/home?region=us-east-1#editJob:isNewlyCreated=false;jobName=daily_avg



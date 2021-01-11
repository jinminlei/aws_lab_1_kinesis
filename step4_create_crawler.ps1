# Create crawler and run it
# Should be update crawler
# test if it should be update-crawler,because the previoulsy created table daily_avg_inefficiency has been blown away
aws glue create-crawler --name 'thermostat-data-crawler' --database-name 'awsblogsgluedemo' --role 'AWSGlueServiceRoleDefault' --targets 'file://crawler-targets.json'
# start crawler
aws glue start-crawler --name 'thermostat-data-crawler'



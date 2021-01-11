# Description
In this repo, I'm gonna do the aws lab by following the instructions in this aws blog post [Unite Real-Time and Batch Analytics Using the Big Data Lambda Architecture, Without Servers!](https://aws.amazon.com/blogs/big-data/unite-real-time-and-batch-analytics-using-the-big-data-lambda-architecture-without-servers/). As I do the lab, I find some errors which I need to fix for making it work correctly. Some ways of creating the resources are too old since the article is written in 2017. I have to make some changes to make it more simple and straightforward. Some instructions are also a little confusing. So make a video hoping it could be helpful to others. This lab is done on windows platform.
# Prerequiste
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html) and [configure aws profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
### Step 1. Create resources by running
```
> .\step1_create_resources.ps1
```
After this you'll see 2 stacks **aws-kinesis** and **aws-kinesis-Kinesis-[some random string]** created. Go to [aws cloudformation console](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks?filteringText=&filteringStatus=active&viewNested=true&hideStacks=false) and check the stacks created.
### Step 2. Generate the cognito user by running
```
> .\step2_create_cognito_user.ps1
```
### Step 3. Generate the sample stream
- Go to [https://awslabs.github.io/amazon-kinesis-data-generator/web/producer.html](https://awslabs.github.io/amazon-kinesis-data-generator/web/producer.html). Click on the Configure button, and fill in the cognito settings that you get from the output of the stack **aws-kinesis**.
**Note:** remember to refresh the page after you have input the cognito settings (This is a bug in the generator page!). 

- From the **Region** drop-down list select **us-east-1**, from the **Stream/delivery stream** drop-down list select **AWSBigDataBlog-RawDeliveryStream**. In the **Record template**, input the following content.
 ```
 {
   "uuid": "{{random.uuid}}",
   "devicets": "{{date.utc("YYYY-MM-DD HH:mm:ss.SSS")}}",
   "deviceid": {{random.number(1000)}},
   "temp": {{random.weightedArrayElement(
     {"weights":[0.33, 0.33, 0.33, 0.01],"data":[70, 71, 72, 78]}
   )}}
 }
 ```
 
 

- Press **Send Data** button
- Go the [Kinesis Analytics](https://console.aws.amazon.com/kinesisanalytics/home?region=us-east-1#/wizard/hub?applicationName=AWSBigDataBlog-AnalyticsApp) checking the Real-time analytics.

# Step 4. Create the crawler and run it
```
> .\step4_create_crawler.ps1
```

# Step 5. Create the job and run it
```
> .\step5_create_glue_job.ps1
```
# Step 6. Go to Athena and do the queries, for example
```
SELECT ( SUM(daily_avg_inefficiency)/COUNT(*) ) AS all_device_avg_inefficiency,
         timestamp
FROM awsblogsgluedemo.daily_avg_inefficiency
GROUP BY  timestamp;

```
# Step 7. Delete all resources created
```
> .\step7_delete_resources.ps1
```


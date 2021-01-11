# Sign up a cognito user 
aws cognito-idp sign-up --client-id d9pa5cl0fdcueqgp63v6hsjl9 --username leijinmin@gmail.com --password !MyPassword1 --user-attributes Name=name,Value=leijinmin Name=email,Value=leijinmin@gmail.com --region us-east-1 --profile default
# Confirm the sign up 
aws cognito-idp admin-confirm-sign-up --user-pool-id us-east-1_98FsFLEpt  --username leijinmin@gmail.com --region us-east-1 --profile default
# Open the Kinesis Generator and add the cognito configuration
# https://awslabs.github.io/amazon-kinesis-data-generator/web/producer.html?upid=us-east-1_MAT1UpOr5&ipid=us-east-1:86098687-2734-495d-a06b-20308035aca2&cid=4rv30fp5vl0aoui8b0ijh3km5g&r=us-east-1

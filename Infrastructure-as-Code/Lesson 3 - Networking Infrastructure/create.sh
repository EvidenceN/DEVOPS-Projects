# can create more scripts wit if/else logic. If this resource exist, update it or describe it. If it doesn't exist, create it. 

aws cloudformation create-stack \
# aws cloudformation update-stack \
# aws cloudformation describe-stack \
--stack-name $1 \
--template-body file://$2 \
--parameters file://$3 \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=us-east-1


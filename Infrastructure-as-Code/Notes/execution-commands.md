# Lesson 3
./create.sh firstfullinfra network.yml network-parameters.json

./update.sh firstfullinfra network.yml network-parameters.json

./describe.sh firstfullinfra


# Lesson 4

./create.sh secondfullinfra servers.yml server-parameters.json

./update.sh secondfullinfra servers.yml server-parameters.json

./describe.sh secondfullinfra

./delete.sh secondfullinfra

Copy data into public server from local computer

scp -i test_access.pem UdacityProjectKey.ppk ec2-user@ec2-3-87-219-46.compute-1.amazonaws.com:/home/ec2-user/UdacityProjectKey.ppk
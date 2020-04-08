#!/usr/bin/env bash

# Update repository
echo ""
echo 'Update repositories'
sudo yum update -y && sudo yum upgrade -y

#Install Docker, docker-compose and set up current user
echo ""
echo ""
echo 'Install Docker, docker-compose and set up current user'
sudo yum install -y docker git
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo service docker start
sudo usermod -a -G docker ec2-user

#Setup ready
echo ""
echo ""
echo "Logout and log back in to use docker as current user"
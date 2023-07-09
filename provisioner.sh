#!/usr/bin/env bash

# update package
sudo apt update
sudo apt upgrade -y

# install git
sudo apt install -y git

# install SSM
curl "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb" -o "amazon-ssm-agent.deb"
sudo dpkg -i amazon-ssm-agent.deb

# install CloudWatch Agent
curl "https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb" -o "amazon-cloudwatch-agent.deb"
sudo dpkg -i amazon-cloudwatch-agent.deb

# install AWS Inspector
curl -O https://inspector-agent.amazonaws.com/linux/latest/install
sudo bash install

# install Docker
sudo apt install -y docker.io
sudo systemctl start docker

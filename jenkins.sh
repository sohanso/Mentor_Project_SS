#!/bin/bash
sudo apt-get -y update
sudo apt -y install openjdk-17-jre
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get -y update
sudo apt-get install -y jenkins
sudo chmod 666 /var/run/docker.sock
sudo systemctl restart docker
sudo sed -i 's/Environment="JENKINS_PORT=8080"/Environment="JENKINS_PORT=8081"/g' /usr/lib/systemd/system/jenkins.service
sudo systemctl daemon-reload
sudo systemctl restart jenkins
sudo apt-get -y install awscli


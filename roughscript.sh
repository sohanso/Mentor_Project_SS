#!/bin/bash
sudo apt-get -y update
sudo apt -y install openjdk-17-jre
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get -y update
sudo apt-get install -y jenkins
sudo usermod -aG sudo jenkins
sudo systemctl restart jenkins

#changing user permission to root
sudo usermod -a -G docker jenkins
sudo systemctl restart jenkins

#to check
grep docker /etc/group


sudo usermod -aG sudo jenkins
sudo systemctl restart jenkins
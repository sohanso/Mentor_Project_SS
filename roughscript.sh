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

sudo sed -i 's/HTTP_PORT=8080/HTTP_PORT=8081/g' /etc/default/jenkins
sudo sed -i 's/--httpPort=$HTTP_PORT/--httpPort=8081/g' /etc/default/jenkins


##Jenkins file for Docker hub push ##

pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t sohanso/ngi-jenkin-test1 .'
                }
                
            }
        }
        stage('Push image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockercred', variable: 'docker_cred')]) {
                    sh 'docker login -u sohanso -p ${docker_cred}'
}

                    sh 'docker push sohanso/ngi-jenkin-test1'
                }
            }
        }
        stage ("Remove container") {
            steps {
                script {
                    sh 'docker container stop $(docker container ls -aq)'
                    sh 'docker container rm $(docker container ls -aq)'
                }
            }
        }
        stage('Run Latest Docker Image') {
            steps {
                script {
                    sh 'docker run -d -p 80:80 --pull always sohanso/ngi-jenkin-test1:latest'
                }
            }
        }
    }
}
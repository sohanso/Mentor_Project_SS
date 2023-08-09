# MENTOR PROJECT - Install nginx on docker using jenkins. Automate process with already installed ansible and Docker
# Mentor: Soham Roy - SCSD Munich
# Mentee: Sohan Sheri - ACSD Pune 

STEP-1
- Create Default VPC required for packer with Terraform.
- Create Main VPC and other Networking resources with Terraform.

STEP-2
- Create packer file .pkr.hcl to create a base image for EC2 which comes pre-installed with ansible and docker.
- Check manually whether required ansible and docker are installed in a Base image by launching EC2 with AMI created.

STEP-3
- Install Jenkins on docker using Ansible

STEP-4
- Create a Docker Image with Nginx having Index.html








## ROUGH NOTES
sudo docker network create jenkins
sudo docker image pull docker:dind
sudo docker run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind --storage-driver overlay2





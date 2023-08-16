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
- Install Jenkins on EC2 with Userdata Script while launching an ec2 with pre-baked Base AMI.

STEP-4
- Create a Jenkins pipeline on Ec2 machine which is integrated SVC github. On every push/pull/changes in github source through pollscm(every 5mins) a new docker image is built and pushed to docker hub.

STEP-5
- Within the pipeline on every new push to docker hub, the docker image is run on Ec2 machine. We can immediately see the contineous deployment on website.








## JENKINS INSTALL ROUGH NOTES
sudo docker network create jenkins
sudo docker image pull docker:dind
sudo docker run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind --storage-driver overlay2




